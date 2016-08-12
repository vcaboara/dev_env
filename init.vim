call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tmhedberg/SimpylFold'               " Code Folding
Plug 'vim-scripts/indentpython.vim'       " Auto-Indentation
Plug 'scrooloose/syntastic'               " Syntax Checking/Highlighting
Plug 'nvie/vim-flake8'                    " PEP8 Checking
Plug 'tpope/vim-fugitive'                 " Git Integration
Plug 'tpope/vim-vinegar'                  " Project Drawer
call plug#end()

" Ctrl-P functionality from fzf
nnoremap <C-p> :FZF<CR>
" Additional SimpylFold config
let g:SimpylFold_docstring_preview=1

" Base settings
set nu                      " Line Number
set encoding=utf-8
set colorcolumn=80	    " Highlight column 80
" Color
colors slate
" Mouse
set mouse=a

" Enable folding with the spacebar
nnoremap <space> za

" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain a min 1 capital letter

" Web indentation
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 | set softtabstop=2 | set shiftwidth=2

" YAML indentation
au BufNewFile,BufRead *.yml
    \ set tabstop=2 | set softtabstop=2 | set shiftwidth=2

" Groovy
au BufNewFile,BufRead Jenkinsfile
    \ set tabstop=4 | set softtabstop=4 | set shiftwidth=4 | set syntax=groovy |
    \ set expandtab | set autoindent | set fileformat=unix
