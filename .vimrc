" Enable loading filetype and indentation plugins
filetype plugin on
filetype indent on

" automatically refresh file when changed
set autoread

" do not wrap lines
set nowrap

" Use menu to show command-line completion (in 'full' case)
set wildmenu

" Ignore special file extensions
set wildignore=*.o,*.obj,*.bak,*.exe,*.DS_Store,*.swp

" Set command-line completion mode:
"   - on first <Tab>, when more than one match, list all matches and complete
"     the longest common  string
"   - on second <Tab>, complete the next full match and show menu
"set wildmode=list:longest,full
set wildmode=list:longest

" Show the mode we are in
set showmode

" non VI compatible
set nocompatible

" set zsh as shell
set shell=/bin/zsh

" set term as $TERM, RXVT in my case
set term=xterm-color

" enable mouse
set mouse=a

" no bell
set vb

" dark background for all
set background=dark

" show line numbers
set number

" 3 numbers per line
set numberwidth=3

" Autoclose folds, when moving out of them
set foldclose=all

" Turn syntax highlighting on
syntax on

" Write contents of the file, if it has been modified, on buffer exit
set autowrite

" Allow backspacing over everything
set backspace=indent,eol,start

" Use UTF-8 as the default buffer encoding
set encoding=utf-8

" Remember up to 100 'colon' commmands and search patterns
set history=1000

" Enable incremental search
set incsearch

" Always show status line
set laststatus=2

" Jump to matching bracket for 2/10th of a second
set matchtime=2

" When a bracket is inserted, briefly jump to a matching one
set showmatch

" Do not highlight results of a search
set nohlsearch

" Show line, column number, and relative position within a file in the status line
set ruler

" Scroll when cursor gets within 3 characters of top/bottom edge
set scrolloff=3

" Round indent to multiple of 'shiftwidth' for > and < commands
set shiftround

" Show (partial) commands (or size of selection in Visual mode) in the status line
set showcmd

" Remember things between sessions
"
" '20  - remember marks for 20 previous files
" \"50 - save 50 lines for each register
" :20  - remember 20 items in command-line history
" %    - remember the buffer list (if vim started without a file arg)
" n    - set name of viminfo file
set viminfo='20,\"50,:20,%,n~/.viminfo

" Go back to the position the cursor was on the last time this file was edited
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")|execute("normal `\"")|endif

" Removes useless spaces
au BufWriteCmd :call TrimWhiteSpace()

" Fix <Backspace> key : <C-v><Backspace> in insert mode"
set t_kb=

" Disable creation of backup file
set nobackup

" Where backups will be stored
" set backupdir=~/.vim/backups

" Where temporary files will be stored
set directory=/tmp/

" tab navigation like firefox
nmap <C-t> :tabnew<cr>
nmap tn :tabnext<CR>
nmap tp :tabprev<CR>
" calling bdelete will delete the current
" buffer and close the current time as well
nmap tc :bdelete<CR>

" map ,f to display all lines with keyword under cursor and ask which one to
" jump to
nmap ,f [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Use F4 to toggle Nerd_Tree
nmap <F4> :NERDTree<CR>

" Use F5 to toggle 'paste' mode
set pastetoggle=<F5>

" use <F6> to toggle line numbers
nmap <F6> :set number!<CR>

" open filename under cursor in a new tab (use current file's working
" directory)
nmap gf :tabnew <cfile><CR>

" overrides ctags ugly CRTRl-]
" nmap gd :tabnew <CR><C-]>

" map <Alt-p> and <Alt-P> to paste below/above and reformat
nnoremap <Esc>P  P'[v']=
nnoremap <Esc>p  p'[v']=

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" support all three, in this order
set fileformats=unix,dos,mac

" everything wraps
set whichwrap=b,s,h,l,<,>,~,[,]

" matches on almost everything, priceless
runtime macros/matchit.vim

" search is case insensitive
set ignorecase

" search becomes case sensitive if there is
" an uppercase character in the search expr
set smartcase

" display the default title at the top of the window
" help title for more infos
set title