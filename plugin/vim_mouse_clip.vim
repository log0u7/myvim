" vim_mouse_clip.vim - OSC52 clipboard over SSH (F9 toggle in
" autoload/mouse_clip.vim)
"
" OSC52: when running over SSH, yanking feeds the LOCAL clipboard with
" the OSC52 escape sequence (it travels through ssh; no +clipboard
" build needed - the Ubuntu vim ships with clipboard=0). Local sessions
" are a no-op: the terminal selection covers that case. Encoding and
" the size cap live in autoload/mouse_clip.vim (smoke-testable).
"
" Opt out entirely: let g:myvim_osc52 = 0 (F9 keeps toggling the mouse).
" Mind the exposure: over SSH, every yank sends buffer text (secrets
" included) to the clipboard of the machine you sshed FROM.

augroup myvim_mouse_clip
  autocmd!
  " Yank -> local clipboard over SSH (OSC52 escape sequence). The
  " yanked lines themselves (regcontents), not the unnamed register: a
  " named-register yank ("ayy) must not send stale @" content.
  autocmd TextYankPost * if v:event.operator ==# 'y' && !empty($SSH_CONNECTION)
        \ | call mouse_clip#osc52(join(v:event.regcontents, "\n"))
        \ | endif
augroup END
