" .vimrc
" @author Kenichi Maehashi

syntax on
set nocompatible

set fileencodings=utf-8,cp932,latin1
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

"""""""""""""""""""""""""""""""""""
""" Misc
"""""""""""""""""""""""""""""""""""
" highlight whitespaces at eol
highlight WhitespaceEOL ctermbg=red guibg=red
autocmd BufNewFile,BufRead,WinEnter * match WhitespaceEOL /\s\+$/
