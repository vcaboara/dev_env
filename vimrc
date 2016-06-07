set nocompatible              " required
filetype off                  " required

"" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"" alternatively, pass a path where Vundle should install plugins
""call vundle#begin('~/some/path/here')

"" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'tmhedberg/SimpylFold'               " Code Folding
Plugin 'vim-scripts/indentpython.vim'       " Auto-Indentation
Plugin 'scrooloose/syntastic'               " Syntax Checking/Highlighting
Plugin 'nvie/vim-flake8'                    " PEP8 Checking
"" Plugin 'Valloric/YouCompleteMe'             " Auto-Complete
Plugin 'jnurmine/Zenburn'                   " Color Schemes
Plugin 'altercation/vim-colors-solarized'   " ... addtl scheme
Plugin 'scrooloose/nerdtree'                " File Tree
Plugin 'jistr/vim-nerdtree-tabs'            " Tabs
Plugin 'kien/ctrlp.vim'                     " Super Searching
Plugin 'tpope/vim-fugitive'                 " Git Integration
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'} " Status Bar
Plugin 'vim-airline/vim-airline'	    " status/tabline
Plugin 'easymotion/vim-easymotion'	    " Vim motions

" All of your Plugins must be added before the following line
call vundle#end()           " required
filetype plugin indent on   " required
set splitbelow
set splitright
set nu                      " Line Number
set encoding=utf-8
set colorcolumn=80	    " Highlight column 80

set t_Co=256                " enable 256 colors
" You may also need to add:
" set t_AB=^[[48;5;%dm
" set t_AF=^[[38;5;%dm

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" PEP8 indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 | set softtabstop=4 | set shiftwidth=4 |
    \ set textwidth=79 | set expandtab | set autoindent | set fileformat=unix

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

" Additional SimpylFold config
let g:SimpylFold_docstring_preview=1

" Additional YouCompleteMe config
" let g:ycm_autoclose_preview_window_after_completion=1
" map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"python with virtualenv support
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"    project_base_dir = os.environ['VIRTUAL_ENV']
"    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"    execfile(activate_this, dict(__file__=activate_this))
"EOF

" Pretty code
let python_highlight_all=1
syntax on

" Color Scheme config
" if has('gui_running')
"     set background=dark
"     colorscheme solarized
" else
"     colorscheme zenburn
" endif
" Toggle color scheme
" call togglebg#map("<F5>")

"" Color
colors slate
"" Mouse
set mouse=a

" Hide .pyc
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain a min 1 capital letter

"" Viminfo; override how many lines of yanks to keep from default
set viminfo='20,"1000,h

"" Paste Mode On/Off 
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

set clipboard=unnamed
