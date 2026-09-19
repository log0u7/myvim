" vim_mouse_clip.vim - OSC52 clipboard over SSH (F6 toggle in
" autoload/mouse_clip.vim)
"
" OSC52: when running over SSH, yanking feeds the LOCAL clipboard with
" the OSC52 escape sequence (it travels through ssh; no +clipboard
" build needed - the Ubuntu vim ships with clipboard=0). Local sessions
" are a no-op: the terminal selection covers that case. Yanks over
" ~100KB are skipped: terminals truncate large sequences silently.

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
