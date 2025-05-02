" vimrc file using vim-plug
call plug#begin("~/.config/nvim/autoload/plug.vim")
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-github-dashboard'      " Browse GitHub events
Plug 'tmhedberg/SimpylFold'               " Code Folding
Plug 'vim-scripts/indentpython.vim'       " Auto-Indentation
Plug 'scrooloose/syntastic'               " Syntax Checking/Highlighting
Plug 'nvie/vim-flake8'                    " PEP8 Checking
Plug 'terryma/vim-multiple-cursors'       " Sublime Text style multiple selections
Plug 'tpope/vim-fugitive'                 " Git Integration
Plug 'tpope/vim-vinegar'                  " Project Drawer
Plug 'valloric/youcompleteme'             " Code-completion
Plug 'vim-airline/vim-airline'            " Status/tabline
Plug 'vim-airline/vim-airline-themes'     "
Plug 'preservim/nerdtree'
" Dictation support
"Plug ''
"Plug 'nvim-cmp'                  " Configurable completion plugin
call plug#end()

"autocmd VimEnter * if !argc() | NERDTree | endif
" NERDTree
" nnoremap <C-n> :NERDTreeToggle<CR>
" Ctrl-P functionality from fzf
nnoremap <C-p> :FZF<CR>
" Additional SimpylFold config
let g:SimpylFold_docstring_preview=1

" Base settings
set nu                      " Line Number
set encoding=utf-8
set colorcolumn=80          " Highlight column 80
" Color
colors slate
" Mouse
set mouse=a
" Viminfo; override how many lines of yanks to keep from default
set viminfo='20,"1000,h
" Paste Mode On/Off
map <F2> :call Paste_on_off()<CR>
set pastetoggle=<F2>

let paste_mode = 0 " 0 = normal, 1 = paste

func! Paste_on_off()
    if g:paste_mode == 0
        set paste
        let g:paste_mode = 1
    else
        set nopaste
        let g:paste_mode = 0
    endif
    return
endfunc

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
