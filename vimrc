" --- Basic Vim Configuration ---
set nocompatible              " This must be the first line
filetype plugin indent on     " Required for vim-plug and many plugins
syntax enable                 " Enable syntax highlighting

" Set leader key (optional, but common)
let mapleader = " "
let maplocalleader = " "

" --- vim-plug Setup ---
" Specify the directory for plugins (standard for Vim)
call plug#begin('~/.vim/plugged')

" --- Plugin List (Vim Compatible) ---
" Only include plugins that work with Vim

" YouCompleteMe (See IMPORTANT note below!)
" Plug 'valloric/YouCompleteMe', { 'do': './install.py' }

Plug 'tmhedberg/SimpylFold'               " Code Folding
Plug 'vim-scripts/indentpython.vim'       " Auto-Indentation
Plug 'scrooloose/syntastic'               " Syntax Checking/Highlighting
Plug 'nvie/vim-flake8'                    " PEP8 Checking

Plug 'jnurmine/Zenburn'                   " Color Schemes
Plug 'altercation/vim-colors-solarized'   " ... addtl scheme
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'            " Tabs
Plug 'kien/ctrlp.vim'                     " Super Searching
Plug 'tpope/vim-fugitive'                 " Git Integration
"Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'} " Status Bar
Plug 'vim-airline/vim-airline'	    " status/tabline
Plug 'easymotion/vim-easymotion'	    " Vim motions
"Plugin 'davidhalter/jedi-vim'           " awesome Python autocompletion with VIM
"Plugin 'klen/python-mode'
Plug 'dracula/vim'                    	" A dark theme for Vim.
Plug 'ekalinin/Dockerfile.vim'		" Dockerfile syntax
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }  " Go Integration

Plug 'honza/vim-snippets'		" Snippets for UltiSnips
Plug 'jiangmiao/auto-pairs'     " Autoclose pairs
Plug 'SirVer/ultisnips' 		" Snippet Engine
Plug 'easymotion/vim-easymotion' 	" Motion plugin

call plug#end()

" --- Plugin Configuration (Vimscript Only) ---

" --- auto-pairs Configuration ---
" Most options are enabled by default, providing automatic pairing of (), [], {}, etc.
" You can customize behavior here if needed.
" To disable auto-pairing on backspace:
" let g:AutoPairsMapBS = 0
" To change the key for jumping out of pairs (default is <C-e> or <CR>):
" let g:AutoPairsShortcutJump = '<M-j>' " Example: Alt+j
" To disable auto-pairing in specific filetypes:
" let g:AutoPairs_disable_filetypes = ['markdown', 'tex']
" --- End auto-pairs Configuration ---

" --- UltiSnips Configuration ---
" Set the trigger key for expanding snippets. <tab> is common.
let g:UltiSnipsExpandTrigger="<tab>"

" Set the trigger key for jumping between snippet placeholders. <tab> is common.
let g:UltiSnipsJumpTrigger="<tab>"

" Optional: Make UltiSnips work with visual selections (e.g., wrapping selected text)
" let g:UltiSnipsEnableVisualSelections = 1

" Optional: Define additional directories where UltiSnips looks for snippet files
" let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips', $HOME.'/.config/nvim/UltiSnips']

" Important: If using with nvim-cmp, ensure your nvim-cmp setup handles <tab>
" appropriately for both completion and snippet expansion.
" --- End UltiSnips Configuration ---

" --- vim-easymotion Configuration ---
" Set the leader key for EasyMotion motions. Defaults to <leader><leader>.
let g:EasyMotion_leader_key = '<leader><leader>'

" Highlight targets (recommended)
let g:EasyMotion_do_mapping = 1
let g:EasyMotion_ForceMotion = 1 " Jump immediately after typing the label

" Optional: Use regular expressions for more flexible targeting
" let g:EasyMotion_use_regexp = 1

" Example Mappings:
" Use <leader><leader>s{char} to find occurrences of {char}
map <leader><leader>s <Plug>(easymotion-s)
" Use <leader><leader>f{char} to find occurrences of {char} on the current line
map <leader><leader>f <Plug>(easymotion-f)
" Use <leader><leader>t{char} to find occurrences of {char} before the cursor on the current line
map <leader><leader>t <Plug>(easymotion-t)
" Use <leader><leader>w to find the beginning of words
map <leader><leader>w <Plug>(easymotion-w)
" Use <leader><leader>b to find the beginning of words backwards
map <leader><leader>b <Plug>(easymotion-b)

" Optional: Bidirectional motions (e.g., jump forward or backward with the same key)
" map <leader><leader>W <Plug>(easymotion-bd-w) " jump to word (bidirectional)
" map <leader><leader>L <Plug>(easymotion-bd-jk) " jump to line (bidirectional)

" Optional: Enable specific motions like `2s` for searching in two lines
" let g:EasyMotion_keys = 'asdflkjh' " Customize keys used for labels

" --- End vim-easymotion Configuration ---

" --- Rest of your custom configuration ---
" (e.g., colorscheme, keybindings, options like set nu, set tabstop, etc.)
set splitbelow
set splitright
set number
set tabstop=4
set shiftwidth=4
set expandtab

set encoding=utf-8
set colorcolumn=80	    " Highlight column 80

set t_Co=256                " enable 256 colors
" ...
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

" Pretty code
let python_highlight_all=1
syntax on

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

" ...
set clipboard=unnamed
