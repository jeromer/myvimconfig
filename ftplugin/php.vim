setlocal autoindent
setlocal smartindent
set nowrap

" display unprintable characters
set list

" Use 4 spaces for (auto)indent
set shiftwidth=4

" Use 4 spaces for <Tab> and :retab
set tabstop=4

" tabs are expanded to spaces
set expandtab

" convert 'tab' as >-
" convert trailing spaces as '-'
set listchars=tab:>-,trail:-

" Load PHP Documentor for VIM
source ~/.vim/php-doc.vim
let PHP_autoformatcomment = 1

" Set up automatic formatting
" t Auto-wrap text using textwidth (does not apply to comments)

" c Auto-wrap comments using textwidth, inserting the current comment
"   leader automatically.

" q Allow formatting of comments with 'gq'.

" l Long lines are not broken in insert mode: When a line was longer than
"   'textwidth' when the insert command started, Vim does not
"   automatically format it.

" r Automatically insert the current comment leader after hitting
"   <Enter> in Insert mode.

" o Automatically insert the current comment leader after hitting 'o' or
"   'O' in Normal mode.
"   Note that formatting will not change blank lines or lines containing
"   only the comment leader.  A new paragraph starts after such a line,
"   or when the comment leader changes.
" :help fo_table
set formatoptions+=tcqlro

" The completion dictionary is provided by Rasmus:
" http://lerdorf.com/funclist.txt
set dictionary-=/usr/share/dict/words dictionary+=~/.vim/dictionaries/phpfunctionslist.txt dictionary+=~/.vim/dictionaries/ezpublishfunctionslist.txt dictionary+=~/.vim/dictionaries/ezpublishtplfunctionslist.txt

" Use the dictionary completion
set complete-=k,u complete+=k
" set complete-=k

" Set maximum text width (for wrapping)
set textwidth=80

" Enable folding of class/function blocks
let php_folding = 1

" Do not use short tags to find PHP blocks
let php_noShortTags = 1

" Char mapping
inoremap [ []<LEFT>
inoremap ( (  )<LEFT><LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap  { {<CR>}<C-O>O

" Map ; to "add ; to the end of the line, when missing"
noremap <buffer> ; :s/\([^;]\)$/\1;/<cr>

" Use PHP syntax check when doing :make
set makeprg=php\ -l\ %

" Parse PHP error output
setlocal errorformat=%m\ in\ %f\ on\ line\ %l

" Function to locate endpoints of a PHP block {{{
function! PhpBlockSelect(mode)
    let motion = "v"
    let line = getline(".")
    let pos = col(".")-1
    let end = col("$")-1

    if a:mode == 1
        if line[pos] == '?' && pos+1 < end && line[pos+1] == '>'
            let motion .= "l"
        elseif line[pos] == '>' && pos > 1 && line[pos-1] == '?'
            " do nothing
        else
            let motion .= "/?>/e\<CR>"
        endif
        let motion .= "o"
        if end > 0
            let motion .= "l"
        endif
        let motion .= "?<\\?php\\>\<CR>"
    else
        if line[pos] == '?' && pos+1 < end && line[pos+1] == '>'
            " do nothing
        elseif line[pos] == '>' && pos > 1 && line[pos-1] == '?'
            let motion .= "h?\\S\<CR>""
        else
            let motion .= "/?>/;?\\S\<CR>"
        endif
        let motion .= "o?<\\?php\\>\<CR>4l/\\S\<CR>"
    endif

    return motion
endfunction
" }}}

" Mappings to select full/inner PHP block
nmap <silent> <expr> vaP PhpBlockSelect(1)
nmap <silent> <expr> viP PhpBlockSelect(0)

" Mappings for operator mode to work on full/inner PHP block
omap <silent> aP :silent normal vaP<CR>
omap <silent> iP :silent normal viP<CR>

" Mappings for PHP Documentor for VIM
inoremap <buffer> <C-P> <Esc>:call PhpDocSingle()<CR>i
nnoremap <buffer> <C-P> :call PhpDocSingle()<CR>
vnoremap <buffer> <C-P> :call PhpDocRange()<CR>

" {{{ Wrap visual selections with chars

:vnoremap <buffer> ( "zdi(<C-R>z)<ESC>
:vnoremap <buffer> { "zdi{<C-R>z}<ESC>
:vnoremap <buffer> [ "zdi[<C-R>z]<ESC>
:vnoremap <buffer> ' "zdi'<C-R>z'<ESC>
" Removed in favor of register addressing
" :vnoremap " "zdi"<C-R>z"<ESC>

" }}} Wrap visual selections with chars

" Map <CTRL>-H to search phpm for the function name currently under the cursor (insert mode only)
inoremap <buffer> <C-H> <ESC>:!phpm <C-R>=expand("<cword>")<CR><CR>

" Generate @uses tag based on inheritance info
let g:pdv_cfg_Uses = 1

" Set default Copyright
" let g:pdv_cfg_Copyright = "Copyright (C) 2010 Jérôme Renard"

" http://svn.toby.phpugdo.de/horde/chora/co.php?r=35&f=.vim%2Fftplugin%2Fphp.vim

" Map <CTRL>-a to alignment function
vnoremap <C-a> :call PhpAlign()<CR>

" Map <CTRL>-a to (un-)comment function
vnoremap <C-c> :call PhpUnComment()<CR>

" {{{ Alignment

func! PhpAlign() range
    let l:paste = &g:paste
    let &g:paste = 0

    let l:line        = a:firstline
    let l:endline     = a:lastline
    let l:maxlength = 0
    while l:line <= l:endline
		" Skip comment lines
		if getline (l:line) =~ '^\s*\/\/.*$'
			let l:line = l:line + 1
			continue
		endif
		" \{-\} matches ungreed *
        let l:index = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\S\{0,1}=\S\{0,1\}\s.*$', '\1', "") 
        let l:indexlength = strlen (l:index)
        let l:maxlength = l:indexlength > l:maxlength ? l:indexlength : l:maxlength
        let l:line = l:line + 1
    endwhile
    
	let l:line = a:firstline
	let l:format = "%s%-" . l:maxlength . "s %s %s"
    
	while l:line <= l:endline
		if getline (l:line) =~ '^\s*\/\/.*$'
			let l:line = l:line + 1
			continue
		endif
        let l:linestart = substitute (getline (l:line), '^\(\s*\).*', '\1', "")
        let l:linekey   = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\(\S\{0,1}=\S\{0,1\}\)\s\(.*\)$', '\1', "")
        let l:linesep   = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\(\S\{0,1}=\S\{0,1\}\)\s\(.*\)$', '\2', "")
        let l:linevalue = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\(\S\{0,1}=\S\{0,1\}\)\s\(.*\)$', '\3', "")

        let l:newline = printf (l:format, l:linestart, l:linekey, l:linesep, l:linevalue)
        call setline (l:line, l:newline)
        let l:line = l:line + 1
    endwhile
    let &g:paste = l:paste
endfunc

" }}}   

" {{{ (Un-)comment

func! PhpUnComment() range
    let l:paste = &g:paste
    let &g:paste = 0

    let l:line        = a:firstline
    let l:endline     = a:lastline

	while l:line <= l:endline
		if getline (l:line) =~ '^\s*\/\/.*$'
			let l:newline = substitute (getline (l:line), '^\(\s*\)\/\/ \(.*\).*$', '\1\2', '')
		else
			let l:newline = substitute (getline (l:line), '^\(\s*\)\(.*\)$', '\1// \2', '')
		endif
		call setline (l:line, l:newline)
		let l:line = l:line + 1
	endwhile

    let &g:paste = l:paste
endfunc

" }}}
" http://vim.sourceforge.net/tips/tip.php?tip_id=922
" nmap ^L :!lynx -accept_all_cookies http://en.php.net/^R^W\#function.^R^W<CR>

" vim: set fdm=marker:

" testing ctags
:set tags=~/.vim/tags/ezpublish.tags

" using pman for the PHP manual
" sudo pear channel-discover doc.php.net && sudo pear install doc.php.net/pman
set keywordprg=pman