set nocompatible                " choose no compatibility with legacy vi
syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

"" Folding 
set foldmethod=indent           "fold based on indent
set foldlevel=100               "Don't autofold anything (but I can still fold manually)

"" Color
color slate

"" Line numbers
set number

set mouse=a                     "enable mouse

"" Indenting, and style related
set shiftwidth=4
set softtabstop=4
syntax enable
set background=dark
set autoindent
set cindent

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
"" Viminfo; override how many lines of yanks to keep from default
set viminfo='20,"1000,h
set colorcolumn=80
execute pathogen#infect()
