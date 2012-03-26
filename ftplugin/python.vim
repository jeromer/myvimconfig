iabbrev codingutf8 # -*- coding: utf-8 -*-

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

inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap { {}<LEFT>

" pip install pyflakes
set makeprg=pyflakes\ %

" highlight any text after virtual column 80
" http://vim.wikia.com/wiki/Highlight_long_lines
match ErrorMsg '\%>79v.\+'

" everything below comes from:
" - https://dev.launchpad.net/UltimateVimPythonSetup
"
" More syntax highlighting.
let python_highlight_all = 1

" Smart indenting
set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

" Auto completion via ctrl-space (instead of the nasty ctrl-x ctrl-o)
set omnifunc=pythoncomplete#Complete
inoremap <Nul> <C-x><C-o>

" Wrap at 72 chars for comments.
set formatoptions=cq textwidth=72 foldignore= wildignore+=*.py[co]

set fdm=marker
