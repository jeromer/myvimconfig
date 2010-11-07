" Function to do <Tab> or completion, based on context {{{
function MyTabOrCompletion()
    let col = col('.')-1
    if !col || getline('.')[col-1] !~ '\k'
        return "\<tab>"
    else
        return "\<C-N>"
    endif
endfunction
" }}}

" VIM tip #878, comment number 4 :  Removing trailing spaces{{{
function TrimWhiteSpace()
    :%s/\s*$//g
    : ''
endfunction
" }}}

map <F2> :call TrimWhiteSpace()<CR>
map! <F2> :call TrimWhiteSpace()<CR>

inoremap <Tab> <C-R>=MyTabOrCompletion()<CR>

" vim: set fdm=marker:
