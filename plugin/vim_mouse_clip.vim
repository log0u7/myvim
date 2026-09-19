" vim_mouse_clip.vim - Mouse capture toggle (F6) and OSC52 clipboard over SSH
"
" F6 flips between vim managing the mouse (visual selection, scrolling)
" and the terminal managing it (native selection: select = terminal
" copy, paste with the terminal binding). The state echoes in the
" message area.
"
" OSC52: when running over SSH, yanking feeds the LOCAL clipboard with
" the OSC52 escape sequence (it travels through ssh; no +clipboard
" build needed - the Ubuntu vim ships with clipboard=0). Local sessions
" are a no-op: the terminal selection covers that case. Yanks over
" ~100KB are skipped: terminals truncate large sequences silently.

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

function! s:osc52(text) abort
  if len(a:text) > 100000 | return | endif
  let l:b64 = trim(system('base64 -w0', a:text))
  call chansend(v:stderr, printf("\e]52;c;%s\a", l:b64))
endfunction

augroup myvim_mouse_clip
  autocmd!
  " Yank -> local clipboard over SSH (OSC52 escape sequence)
  autocmd TextYankPost * if v:event.operator ==# 'y' && !empty($SSH_CONNECTION)
        \ | call s:osc52(@")
        \ | endif
augroup END
