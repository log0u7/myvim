" vim_aliases.vim - command aliases
" (vim_* convention: pure Vim config)

" Command aliases (command!: survives re-sourcing and collisions)
command! W w !sudo tee > /dev/null %
command! Q qa!