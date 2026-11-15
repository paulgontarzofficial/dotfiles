" ~/.vimrc -- managed in github.com/paulgontarzofficial/dotfiles

set nocompatible
filetype plugin indent on
syntax on

" --- Indentation ---
set tabstop=2 shiftwidth=2 softtabstop=2
set expandtab autoindent smartindent

" --- Interface ---
set number relativenumber
set colorcolumn=80
set mouse=a
set termguicolors
colorscheme industry

" --- Search ---
set ignorecase smartcase incsearch hlsearch

" --- Persistent undo ---
let s:undo_dir = expand('~/.vim/undo')
if !isdirectory(s:undo_dir)
  call mkdir(s:undo_dir, 'p')
endif
set undofile
let &undodir = s:undo_dir . '//'
