""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bogado/file-line'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" leader 
let mapleader="\<Space>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" tabs
nnoremap <Leader>t :tabe<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" TAB spaces
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
"set expandtab       " tabs are spaces
set shiftwidth=4
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" tags
"nnoremap <C-[> <C-t>

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
set paste
" highlight last inserted text
nnoremap gV `[v`]
set laststatus=2
set cursorline
highlight CursorLine ctermbg=Black cterm=none gui=none

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" search
set incsearch       " search as characters are entered
set hlsearch        " highlight matches
set ignorecase
set smartcase 		" searching for aaaaa will be case-insensitive
					" whereas aAaaa will be case-sensitive

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" quit / save
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :q!<CR>
nnoremap <Leader>wq :wq<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" navigating windows
set splitbelow
set splitright
nnoremap <C-Left> <C-w>h
nnoremap <C-Down> <C-w>j
nnoremap <C-Up> <C-w>k
nnoremap <C-Right> <C-w>l

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" syntax & coloring
syntax on
hi! link cTodo Underlined	" custom color to highlight TODO
							" the default one doesn't work with dark gnome-terminal

" use this mapping to get the color settings under cursor
nnoremap <Leader>hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" autocomplete
filetype plugin indent on " use the builtin pythoncomplete.vim
set runtimepath^=~/.vim/bundle/ag

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" tags
set cscopetag		" look for cscope tags as well
set csre			" relative paths

" autoload cscope database
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  " else add the database pointed to by environment variable 
  elseif $CSCOPE_DB != "" 
    cs add $CSCOPE_DB
  endif
endfunction
au BufEnter /* call LoadCscope()

