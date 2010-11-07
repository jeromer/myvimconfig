" -*- vim -*-
" @(#) $Id: VimITunes.vim,v 1.0 2003-01-09 07:55:44 EST eralston exp $
"
" Vim global plugin for controlling iTunes from within Vim.
" Last Change: 2003-01-09 07:55:44
" Maintainer: Ed Ralston <eralston@techsan.org>
"
" created 2003-01-07 13:42:21 eralston@techsan.org
"
" Copyright 2003 Ed Ralston
" Free distribution, use, and modification permitted under GPL2.
"
" For the latest version of this file, see:
" http://www.vim.org/script.php?script_id=523
"
" Loosely based on vimxmms.vim by Danie Roux <droux@tuks.co.za>:
" http://www.vim.org/script.php?script_id=28
"
" DESCRIPTION:
"    Allows controlling iTunes on Macintosh from within Vim.
"    Adds a menu "iTunes" that contains various commands to
"    control iTunes.
"    Additionally, if the global variable "VimITunesMapPrefix" is
"    set when this plugin is loaded, then several useful maps
"    are created.  For example, if in your ".vimrc" you have
"
"       let g:VimITunesMapPrefix = ",x"
"
"    then after this plugin is loaded, you can use the following maps:
"
"           ,xq    Quit iTunes
"
"           ,xs    Toggle Shuffle Mode
"           ,xp    Toggle Pause Mode
"
"           ,xl    Next Song
"           ,xh    Previous Song
"
"           ,xk    Volume Up
"           ,xj    Volume Down
"           ,xm    Mute
"           ,x?    Display Song Title
"
"           ,xd    Disable the current song
"           ,xe    Enable the current song
"
" INSTALLATION:
"     Put this file into your plugin directory
"     (do ":help *add-global-plugin*" for assistance on how to do that).
"     If you want to use the mappings, then in your ".vimrc" file,
"     add something like the following:
"
"       let g:VimITunesMapPrefix = ",x"
"
" BUGS:
"     Can lock up if used while iTunes is shutting down (i.e.,
"     if you issue a VimITunes command within approx. 10 seconds
"     after telling iTunes to quit).  This appears to be a bug
"     in osascript (supplied by Apple), and not this script.
"
"

" gnothi seauton
if exists( "loaded_VimITunes" )
   finish
endif
let loaded_VimITunes = 1



" Search for osascript, and only if it's found, assume we're on a macintosh.
if filereadable( "/usr/bin/osascript" )
   let s:Osa = "/usr/bin/osascript"
elseif filereadable( "/usr/sbin/osascript" )
   let s:Osa = "/usr/sbin/osascript"
elseif filereadable( "/bin/osascript" )
   let s:Osa = "/bin/osascript"
elseif filereadable( "/sbin/osascript" )
   let s:Osa = "/sbin/osascript"
else
   " Hmm, guess we're not on a Mac.  Bail out.
   finish
endif


let s:msg_NotRunning = "ERROR: iTunes not running"


if exists( "g:VimITunesMapPrefix" )
   let s:map_prefix = substitute( g:VimITunesMapPrefix, "\\", "\\\\", "g" )
endif


function! s:MkMenu( title, shortcut, cmd )
   if exists( "s:map_prefix" ) && strlen( a:shortcut )
      let l:map_prefix = substitute( s:map_prefix, "\\", "\\\\\\", "g" )

      " Hmm, this is what we _should_ be doing, but it
      " currently doesn't seem to work in vim6.1.255
      "exe "800 amenu iTunes." . a:title
      "        \ . "<Tab>" . l:map_prefix . a:shortcut
      "        \ . " " . a:cmd

      " do this instead, until mac-vim supports right-aligned menus items.
      exe "800 amenu iTunes." . a:title
              \ . "\\ (" . l:map_prefix . a:shortcut . ")"
              \ . " " . a:cmd
   else
      exe "800 amenu iTunes." . a:title
              \ . " " . a:cmd
   endif
endfunction

function! s:MkMap( char, cmd )
   exe ":noremap <silent> <unique> " . s:map_prefix . a:char . " " . a:cmd
endfunction


" Declare our maps only if the "s:map_prefix" variable is set
if exists( "s:map_prefix" )

   call s:MkMap( "q" , ":echo VimITunesQuit()<cr>" )

   call s:MkMap( "s" , ":echo VimITunesToggleShuffle()<cr>" )
   call s:MkMap( "p" , ":echo VimITunesTogglePause()<cr>" )

   call s:MkMap( "n" , ":echo VimITunesNextSong()<cr>" )
   call s:MkMap( "l" , ":echo VimITunesNextSong()<cr>" )
   call s:MkMap( "+" , ":echo VimITunesNextSong()<cr>" )
   call s:MkMap( "b" , ":echo VimITunesPrevSong()<cr>" )
   call s:MkMap( "h" , ":echo VimITunesPrevSong()<cr>" )
   call s:MkMap( "-" , ":echo VimITunesPrevSong()<cr>" )

   call s:MkMap( "k" , ":echo VimITunesVolumeUp(10)<cr>" )
   call s:MkMap( "j" , ":echo VimITunesVolumeDown(10)<cr>" )
   call s:MkMap( "m" , ":echo VimITunesVolumeMute()<cr>" )
   call s:MkMap( "?" , ":echo VimITunesCurrentlyPlaying ()<cr>" )

   call s:MkMap( "d" , ":call VimITunesDisablePlaying()<cr>" )
   call s:MkMap( "e" , ":call VimITunesEnablePlaying()<cr>" )

endif

" here goes the menu
call s:MkMenu( "Play", "", ":echo VimITunesPlay()<CR>" )
call s:MkMenu( "Stop", "", ":echo VimITunesStop()<CR>" )
call s:MkMenu( "Toggle\\ Pause", "p", ":echo VimITunesTogglePause()<CR>" )
call s:MkMenu( "-Sep1-", "", ":" )
call s:MkMenu( "Next\\ Song", "l", ":echo VimITunesNextSong()<CR>" )
call s:MkMenu( "Previous\\ Song", "h", ":echo VimITunesPrevSong()<CR>" )
call s:MkMenu( "-Sep2-", "", ":" )
call s:MkMenu( "Toggle\\ Shuffle", "s", ":echo VimITunesToggleShuffle()<CR>" )
call s:MkMenu( "Repeat\\ Off", "", ":echo VimITunesRepeatOff()<CR>" )
call s:MkMenu( "Repeat\\ All", "", ":echo VimITunesRepeatAll()<CR>" )
call s:MkMenu( "Repeat\\ One", "", ":echo VimITunesRepeatOne()<CR>" )
call s:MkMenu( "-Sep3-", "", ":" )
call s:MkMenu( "Volume\\ Up", "k", ":echo VimITunesVolumeUp(10)<CR>" )
call s:MkMenu( "Volume\\ Down", "j", ":echo VimITunesVolumeDown(10)<CR>" )
call s:MkMenu( "Mute", "m", ":echo VimITunesVolumeMute()<CR>" )
call s:MkMenu( "-Sep4-", "", ":" )
call s:MkMenu( "Display\\ Song\\ Title", "?", ":echo VimITunesCurrentlyPlaying()<CR>" )
call s:MkMenu( "Disable\\ Song", "d", ":echo VimITunesDisablePlaying()<CR>" )
call s:MkMenu( "Enable\\ Song", "e", ":echo VimITunesEnablePlaying()<CR>" )

" these were used to set up the menu and maps; no longer needed.
delfunction s:MkMap
delfunction s:MkMenu
unlet s:map_prefix


function! TellVimITunes( ... )
   if a:0 == 0
      return
   endif

   let l:cmd = ""
   let l:argn = 1
   while l:argn <= a:0
      exe "let l:cmd = l:cmd . a:" . l:argn . ". \"\\\n\""
      let l:argn = l:argn + 1
   endwhile

   return system( "echo "
           \ . "\"tell application \\\"iTunes\\\"\n"
           \ . l:cmd 
           \ . "end tell\n\" | " . s:Osa )
endfunction


function! IsITunesRunning()
   return system( "echo "
           \ . "\"tell application \\\"Finder\\\"\n"
           \ . "if name of processes contains \\\"iTunes\\\" then\n"
           \ . "get \\\"1\\\"\n"
           \ . "else\nget \\\"0\\\"\n"
           \ . "end if\nend tell\n\" | " . s:Osa )
endfunction


function! VimITunesToggleShuffle()
   if ( !IsITunesRunning() )
      return s:msg_NotRunning
   endif

   let l:is_shuffled = TellVimITunes( "get shuffle of the current playlist" )
   if ( stridx( l:is_shuffled, "false" ) >= 0 )
      call TellVimITunes( "set shuffle of the current playlist to true" )
      return 'iTunes Playlist Shuffled'
   else
      call TellVimITunes( "set shuffle of the current playlist to false" )
      return 'iTunes Playlist In order'
   endif
endfunction


function! VimITunesPlay()
   if ( !IsITunesRunning() )
      return s:msg_NotRunning
   endif

   call TellVimITunes( "play" )
   return 'iTunes Playing'
endfunction


function! VimITunesStop()
   if ( !IsITunesRunning() )
      return s:msg_NotRunning
   endif

   call TellVimITunes( "stop" )
   return 'iTunes Stopped'
endfunction


function! VimITunesTogglePause()
   if ( !IsITunesRunning() )
      return s:msg_NotRunning
   endif

   call TellVimITunes( "playpause" )
   let l:state = TellVimITunes( "get player state" )
   if ( ( stridx( l:state, "pause" ) >= 0 )
           \ || ( stridx( l:state, "stop" ) >= 0 ) )
      return 'iTunes Paused'
   else
      return 'iTunes Playing'
   endif
endfunction


function! VimITunesNextSong()
   if ( !IsITunesRunning() )
      return s:msg_NotRunning
   endif

   return TellVimITunes( "next track", "get name of current track" )
endfunction


function! VimITunesPrevSong()
   if ( !IsITunesRunning() )
      return s:msg_NotRunning
   endif

   return TellVimITunes( "previous track", "get name of current track" )
endfunction


function! VimITunesQuickPrevSong()
   if ( !IsITunesRunning() )
      return s:msg_NotRunning
   endif

   return TellVimITunes( "next track" )
endfunction


function! VimITunesQuickNextSong()
   if ( !IsITunesRunning() )
      return s:msg_NotRunning
   endif

   return TellVimITunes( "previous track" )
endfunction


function! VimITunesCurrentlyPlaying()
   if ( !IsITunesRunning() )
      return s:msg_NotRunning
   endif

   return TellVimITunes( "get name of current track" )
endfunction


function! VimITunesVolumeUp( percentage_points )
   if ( !IsITunesRunning() )
      return s:msg_NotRunning
   endif

   let l:volume = TellVimITunes( "get sound volume" ) + a:percentage_points
   if ( l:volume > 100 )
      let l:volume = 100
   endif
   call TellVimITunes( "set sound volume to "  . l:volume )
   return "iTunes volume set to " . l:volume . "%"
endfunction


function! VimITunesVolumeDown( percentage_points )
   if ( !IsITunesRunning() )
      return s:msg_NotRunning
   endif

   let l:volume = TellVimITunes( "get sound volume" ) - a:percentage_points
   if ( l:volume < 0 )
      let l:volume = 0
   endif
   call TellVimITunes( "set sound volume to "  . l:volume )
   return "iTunes volume set to " . l:volume . "%"
endfunction


function! VimITunesVolumeMute()
   if ( !IsITunesRunning() )
      return s:msg_NotRunning
   endif

   let l:is_muted = TellVimITunes( "get mute" )
   if ( stridx( l:is_muted, "false" ) >= 0 )
      call TellVimITunes( "set mute to true" )
      return 'iTunes muted'
   else
      call TellVimITunes( "set mute to false" )
      return 'iTunes un-muted'
   endif
endfunction


function! VimITunesGetTime()
   if ( !IsITunesRunning() )
      return s:msg_NotRunning
   endif

   return TellVimITunes( "get player position" )
endfunction


function! VimITunesSetTime( time )
   if ( !IsITunesRunning() )
      return s:msg_NotRunning
   endif

   return TellVimITunes( "pause", "set player position to " . a:time )
endfunction


function! VimITunesQuit()
   if ( !IsITunesRunning() )
      return s:msg_NotRunning
   endif

   return TellVimITunes( "quit" )
endfunction


function! VimITunesDisablePlaying()
   if ( !IsITunesRunning() )
      return s:msg_NotRunning
   endif

   return TellVimITunes( "set enabled of current track to false" )
endfunction


function! VimITunesEnablePlaying()
   if ( !IsITunesRunning() )
      return s:msg_NotRunning
   endif

   return TellVimITunes( "set enabled of current track to true" )
endfunction


function! VimITunesRepeatOff()
   if ( !IsITunesRunning() )
      return s:msg_NotRunning
   endif

   return TellVimITunes( "set song repeat of current playlist to off" )
endfunction


function! VimITunesRepeatOne()
   if ( !IsITunesRunning() )
      return s:msg_NotRunning
   endif

   return TellVimITunes( "set song repeat of current playlist to one" )
endfunction


function! VimITunesRepeatAll()
   if ( !IsITunesRunning() )
      return s:msg_NotRunning
   endif

   return TellVimITunes( "set song repeat of current playlist to all" )
endfunction

" vim:set ai et sw=3 ft=vim:
