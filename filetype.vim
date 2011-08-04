"
" Filetype detection
"
augroup filetypedetect

    " Detect .txt as 'text'
    au BufNewFile,BufRead *.txt setf text

    " Detect .phps and .phpt as 'php'
    au BufRead,BufNewFile *.phps setf php
    au BufRead,BufNewFile *.phpt setf php

    " Detect .tpl as 'html'
    au BufNewFile,BufRead *.tpl setf smarty

    " Detect .xt as .xt files : Xdebug traces
    au BufNewFile,BufRead *.xt  setf xt

    " Detect .rst.txt as .rst files
    au BufNewFile,BufRead *.rst  setf rst

    " Detect .rest files as .rst files
    au BufNewFile,BufRead *.rest  setf rst

    " Detect .h files as .c files
    au BufNewFile,Bufread *.h setf c

    " Detect .ini.append.php as .ini files
    au BufNewFile,Bufread *.ini.append.php setf dosini

    " Detect .wiki as wiki files
    au BufNewFile,Bufread *.wiki setf wiki

    " Detect .py as python
    au BufNewFile,BufRead *.py setf python

    " Detext .taskpaper as taskpaper
    au BufNewFile,BufRead *.taskpaper setf taskpaper

    " Varnish Configuraiton Files
    au BufNewFile,BufRead *.vcl setf vcl

    " Dtrace files
    au BufNewFile,BufRead *.d setf dtrace

augroup END
