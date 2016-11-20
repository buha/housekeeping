""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" plugin manager
execute pathogen#infect()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" tabs
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" navigation
" move vertically by visual line
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" interface
set number 	        " show line numbers
set showcmd         " show command in bottom bar
filetype indent on  " load filetype-specific indent files
set wildmenu        " visual autocomplete for command menu
set showmatch       " highlight matching [{()}]
" highlight last inserted text
nnoremap gV `[v`]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" search
set incsearch       " search as characters are entered
set hlsearch        " highlight matches
" de-highlight matches by pressing spacebar 
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" leader shortcuts
let mapleader=","       " leader is comma
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>
" save session - TODO:improve this, it creates a Session.vim a
" in the directory
nnoremap <leader>s :mksession<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" tabs
nnoremap <leader>t :tabe<CR>
nnoremap <leader><Tab> :tabn<CR>
nnoremap <leader><S-Tab> :tabp<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" syntax & coloring
syntax on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" autocomplete
filetype plugin indent on " use the builtin pythoncomplete.vim
