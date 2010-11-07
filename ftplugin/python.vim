set omnifunc=pythoncomplete#Complete

" configure expanding of tabs for various file types
au BufRead,BufNewFile *.py set expandtab
au BufRead,BufNewFile *.c set noexpandtab
au BufRead,BufNewFile *.h set noexpandtab
au BufRead,BufNewFile Makefile* set noexpandtab

" enter spaces when tab is pressed
set expandtab

" break lines when line length increases
set textwidth=120

" use 4 spaces to represent tab
set tabstop=4
set softtabstop=4

" number of spaces to use for auto indent
set shiftwidth=4

" copy indent from current line when starting a new line
set autoindent

" convert 'tab' as >-
" convert trailing spaces as '-'
set listchars=tab:>-,trail:-

inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap { {}<LEFT>
