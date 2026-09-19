" mouse_clip.vim - autoload for the mouse capture toggle (F9)
"
" F9 flips between vim managing the mouse (visual selection, scrolling)
" and the terminal managing it (native selection: select = terminal
" copy, paste with the terminal binding). The state echoes in the
" message area. Lives in autoload/: a '#' function name is only legal
" in a file matching its autoload path (E746).
" F2-F6/F10 stay available for vdebug inside a debug session
" (buffer-local mappings win there).

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

" Base64 payload for OSC52. The ~100KB cap counts BYTES (strlen):
" terminals truncate large sequences silently. Plain `base64` wraps at
" 76 columns on GNU (BSD/macOS does not wrap); stripping CR/LF yields
" the single-line payload both accept (no GNU-only -w0 dependency).
function! mouse_clip#encode(text) abort
  if strlen(a:text) > 100000 | return '' | endif
  return substitute(system('base64', a:text), '[\r\n]', '', 'g')
endfunction

" Send text to the LOCAL clipboard over SSH.
function! mouse_clip#osc52(text) abort
  call chansend(v:stderr, printf("\e]52;c;%s\a", mouse_clip#encode(a:text)))
endfunction
