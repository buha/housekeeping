""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" plugins
execute pathogen#infect()
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Initialize plugin system
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" leader 
let mapleader="\<Space>"
" toggle gundo

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" tabs
nnoremap <Leader>t :tabe<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" TAB spaces
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" autocomplete
filetype plugin indent on " use the builtin pythoncomplete.vim
set runtimepath^=~/.vim/bundle/ag
