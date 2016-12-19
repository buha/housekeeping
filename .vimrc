""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" plugins
execute pathogen#infect()
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Initialize plugin system
call plug#end()

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

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" leader shortcuts
let mapleader="\<Space>"
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>
" save session - TODO:improve this, it creates a Session.vim a
" in the directory
nnoremap <leader>s :mksession<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :q!<CR>
nnoremap <Leader>wq :wq<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" tabs
nnoremap <C-t> :tabe<CR>

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
