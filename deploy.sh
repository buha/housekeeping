#!/bin/bash
set -e

# constants 
BOLD="\e[1m"
NORMAL="\e[21m"
CHANGEFILE=changeload.cmd

help()
{
    echo "Usage: deploy [-h|--help]"
    echo "       deploy [-n|--dry-run]"
    echo "              [-c|--changeload user/password@host]"
    echo "              [/path/to/source] [[user@]host:]/path/to/destination"
	echo
	echo "If not /path/to/source is given, it will attempt to deploy recursively"
	echo "from current directory, provided that it is a child directory of CVSROOT."
}

OPTS=`getopt -o hnc: --long dry-run,help,changeload: -n 'parse-options' -- "$@"`
if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi
echo $OPTS
eval set -- "$OPTS"

HELP=false
DRY_RUN=false

while true; do
  case "$1" in
    -h | --help )    HELP=true; shift ;;
    -n | --dry-run ) DRY_RUN=true; shift ;;
    -c | --changeload ) LOAD_CHANGES="$2"; shift; shift ;;
    -- ) shift; POS1=$1; POS2=$2; shift; break ;;
    * ) break ;;
  esac
done

if [ $HELP == true ]; then
    help    
    exit 0
fi

if ! [ -z $LOAD_CHANGES ]; then
    TELNET_USER=$(echo "$LOAD_CHANGES" | perl -ne 'if( m|([a-zA-Z]*)\/(.+)@([^:]*):?(.+)?| ) { print $1; };')
    TELNET_PASS=$(echo "$LOAD_CHANGES" | perl -ne 'if( m|([a-zA-Z]*)\/(.+)@([^:]*):?(.+)?| ) { print $2; };')
    TELNET_HOST=$(echo "$LOAD_CHANGES" | perl -ne 'if( m|([a-zA-Z]*)\/(.+)@([^:]*):?(.+)?| ) { print $3; };')
    TELNET_DIR=$(echo "$LOAD_CHANGES" | perl -ne 'if( m|([a-zA-Z]*)\/(.+)@([^:]*):?(.+)?| ) { print $4; };')
    if [ -z $TELNET_USER ] || [ -z $TELNET_PASS ] || [ -z $TELNET_HOST ] || [ -z $TELNET_DIR ]; then
        help
        exit 0
    fi
fi

if [ -z $POS2 ] && ! [ -z $POS1]; then
    # try to sync from current working directory
	cvsroot=$(echo $CVSROOT | perl -ne 'if( m|.+:(.+)@(.+):(\/.*)| ) { print $3; };')

	if [[ $(pwd) == "$cvsroot"* ]]; then
		FROM=$(echo $(pwd) | perl -ne "if( m|(${cvsroot//\//\\/}\/?([^/]*))| ) { print \$1; };") 
		if [ -z $FROM ]; then
			echo This script only deploys projects under CVSROOT\($cvsroot\). Your working directory is $(pwd)
			exit 0
		fi
		TO=$POS1 
	else
		echo This script only deploys projects under CVSROOT\($CVSROOT\). Your working directory is $(pwd)
		exit 0
	fi
elif [ -z $POS1 ]; then
	help
	exit 0
else
	FROM=$POS1
	TO=$POS2
fi    

SSH_USER=$(echo "$TO" | perl -ne 'if( m|(([a-zA-Z]*)@)?(.+):(.+)| ) { print $2; };')
SSH_HOST=$(echo "$TO" | perl -ne 'if( m|(([a-zA-Z]*)@)?(.+):(.+)| ) { print $3; };')
SSH_DIR=$(echo "$TO" | perl -ne 'if( m|(([a-zA-Z]*)@)?(.+):(.+)| ) { print $4; };')
if [ -z $SSH_HOST ] || [ -z $SSH_DIR ]; then 
	help
	exit 0
fi 

if [ $DRY_RUN == false ]; then
	dryrun=''
	syncmessage="Syncing"
else
	dryrun='-n'
	syncmessage="Syncing simulation "
fi
echo -e "$syncmessage from $BOLD$FROM$NORMAL to $BOLD$SSH_DIR$NORMAL"
exec 5>&1

changelist=$(rsync -uaiP $dryrun --delete --one-file-system --log-file=rsync.log --include "*/"  --include="*.o" --exclude="*" \
           $FROM $TO | grep '^<' | awk '{ print $2 }' | tee >(cat - >&5))

if [[ -z $changelist ]]; then
    echo "Files are up to date"	
    exit 0
else
filterlist=$(
python - << EOF
#!/usr/bin/python3
import sys
import re

regex = r"Entering directory .+?\/Prb\/code\/\w+\'(.|\n)+?ldppc .*-o ([^.]*.o)"

with open("nul_poctogem", 'r') as f:                                                                                                                                                                                         
	data=f.read()

matches = re.finditer(regex, data, re.MULTILINE)

for matchNum, match in enumerate(matches):
	print(match.group(2))
EOF
)

	echo FILTERLIST=$filterlist
 	#for i in $changelist; do
	#	if [ $(echo $filterlist | grep -q $i) ]; then
	#		filteredlist=	
fi

if ! [ -z $LOAD_CHANGES ] && [ $DRY_RUN == false ]; then
    
    # create changeload script    
    echo -n "Transferring $CHANGEFILE to $TELNET_HOST..."
    echo -e "# mount network share and cd to the mountpoint" > $CHANGEFILE
    echo -e "iam \"$SSH_USER\"" >> $CHANGEFILE
    echo -e "netDevCreate \"pingu:\",\"$(getent hosts $SSH_HOST | awk '{ print $1 }')\",0" >> $CHANGEFILE
    echo -e "cd \"pingu:\"" >> $CHANGEFILE
    echo -e "previousWorkingDirectory=malloc(128)" >> $CHANGEFILE
    echo -e "getcwd(previousWorkingDirectory,128)" >> $CHANGEFILE
    echo -e "\n# unload/load changed objects" >> $CHANGEFILE
    for o in $changelist; do
        echo -e "unld \"$(basename $o)\"" >> $CHANGEFILE
        echo -e "ld < $SSH_DIRPREFIX/$o" >> $CHANGEFILE
    done
    echo -e "\n# changed the working directory to its previous value" >> $CHANGEFILE
    echo -e "cd previousWorkingDirectory" >> $CHANGEFILE
    echo -e "free previousWorkingDirectory" >> $CHANGEFILE

ftp -inv $TELNET_HOST << EOF
user $TELNET_USER $TELNET_PASS
cd $TELNET_DIR
put $CHANGEFILE
bye
EOF

    echo -e "done."
fi
