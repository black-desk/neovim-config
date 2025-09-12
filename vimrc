" SPDX-FileCopyrightText: 2025 Chen Linxuan <me@black-desk.cn>
"
" SPDX-License-Identifier: MIT

" vim:ft=vim:

let g:mapleader=";"
let g:maplocalleader=" "
set spell
set spelllang=en_us
set clipboard+=unnamedplus
set ignorecase
set updatetime=100
set number
set relativenumber
set mouse=nv
set nowrap
set tabstop=8
set shiftwidth=8
set softtabstop=8
set cursorline
set hlsearch
set colorcolumn=81
set signcolumn=yes
set foldlevel=99

" https://unix.stackexchange.com/a/260277
nnoremap <leader><tab><tab> mc80A <esc>080lDgelD`cP

" exit insert mode in terminal
tnoremap <ESC><ESC> <C-\><C-n>

" open terminal in new buffer
nnoremap <leader>T :terminal<CR>

" open global config file in new tab
nnoremap <silent> <leader>vimrc :execute 'edit ' . stdpath('config') . '/init.lua'<CR>

if has('nvim')
	finish
endif

nnoremap <silent> <leader>vimrc :execute 'edit ' .  expand('$MYVIMRC')<CR>

if empty(glob('~/.vim/autoload/plug.vim'))
	silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-fugitive'
call plug#end()
