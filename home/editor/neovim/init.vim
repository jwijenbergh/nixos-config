call plug#begin('~/.vim/plugged')

Plug 'dracula/vim' " Colorscheme
Plug 'itchyny/lightline.vim' " Status line
Plug 'LnL7/vim-nix' " Syntax highlighting for .nix files
Plug 'ruudjelinssen/proverif-pi-vim'

call plug#end()

let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ }

set number relativenumber
set nu rnu

syntax on 
set mouse=a

set background=dark
colorscheme dracula
set termguicolors

au BufRead,BufNewFile *.pv setfiletype proverif
set t_Co=256

let mapleader=" "

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set tabstop=4 
set showmatch " Shows matching brackets
set ruler " Always shows location in file (line#)
set smarttab " Autotabs for certain code
set shiftwidth=4
