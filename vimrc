" .vimrc
" @author Kenichi Maehashi

syntax on
set nocompatible

set fileencodings=utf-8,cp932,euc-jp,latin1
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
nmap <silent> <Esc><Esc> :nohlsearch<CR>
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

" highlight at column 80
let &colorcolumn=80

set nowritebackup
set nobackup
set noswapfile

set showmatch
set matchpairs& matchpairs+=<:>

" jump to matching pair by TAB
nnoremap <Tab> %
vnoremap <Tab> %

" move window by Ctrl + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" super user save
cmap w!! w !sudo tee > /dev/null %

" always show filename
set laststatus=2

"""
""" Filename based options
"""
" Markdown (GitHub flavored)
autocmd BufNewFile,BufRead *.md set filetype=ghmarkdown
" Python
autocmd BufRead,BufNewFile *.pxi set filetype=python
autocmd BufRead,BufNewFile *.pyi set filetype=python
" Perl Template Toolkit
autocmd BufRead,BufNewFile *.tt set filetype=html
" GNU Make
autocmd BufRead,BufNewFile Makefile* set noexpandtab
" Go
autocmd BufRead,BufNewFile *.go set noexpandtab filetype=go
autocmd FileType go :highlight goErr cterm=bold ctermfg=214
autocmd FileType go :match goErr /\<err\>/
