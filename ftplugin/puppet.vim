" enter spaces when tab is pressed
set expandtab

" break lines when line length increases
set textwidth=79

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

inoremap ( ()<LEFT>
inoremap { {<CR>}

" highlight any text after virtual column 80
" http://vim.wikia.com/wiki/Highlight_long_lines
match ErrorMsg '\%>79v.\+'

set fdm=syntax
