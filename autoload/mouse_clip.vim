" mouse_clip.vim - autoload for the mouse capture toggle (F6)
"
" F6 flips between vim managing the mouse (visual selection, scrolling)
" and the terminal managing it (native selection: select = terminal
" copy, paste with the terminal binding). The state echoes in the
" message area. Lives in autoload/: a '#' function name is only legal
" in a file matching its autoload path (E746).

" Toggle between vim-managed and terminal-managed mouse.
function! mouse_clip#toggle() abort
  if &mouse ==# ''
    set mouse=a
    echo 'mouse: vim (visual selection)'
  else
    set mouse=
    echo 'mouse: terminal (native selection)'
  endif
endfunction
