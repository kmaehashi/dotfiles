" .vimrc
" @author Kenichi Maehashi

syntax on
set nocompatible

set fileencodings=utf-8,utf-16,cp932,euc-jp,latin1
set backspace=indent,eol,start

set viminfo='20,\"50
set history=50
set textwidth=0
set ruler
set number
set wildmenu
set showcmd

set visualbell

"""""""""""""""""""""""""""""""""""
""" Indent
"""""""""""""""""""""""""""""""""""
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
" use spaces instead of tabs
set expandtab

"""""""""""""""""""""""""""""""""""
""" Search
"""""""""""""""""""""""""""""""""""
" incremental
set incsearch
" highlight results
set hlsearch
" cancel highlight
nnoremap <C-L> :nohl<CR><C-L>
" case-insensitive search
set ignorecase
" case-sensitive when query contains large characters
set smartcase
" enable use of special characters
set magic

"""""""""""""""""""""""""""""""""""
""" Misc
"""""""""""""""""""""""""""""""""""
" highlight whitespaces at eol
highlight WhitespaceEOL ctermbg=red guibg=red
autocmd BufNewFile,BufRead,WinEnter * match WhitespaceEOL /\s\+$/

"""
""" Filename based options
"""
" Waf build scripts
autocmd BufRead,BufNewFile wscript set filetype=python
" Perl Template Toolkit
autocmd BufRead,BufNewFile *.tt set filetype=html
" GNU Make
autocmd BufRead,BufNewFile Makefile* set noexpandtab
