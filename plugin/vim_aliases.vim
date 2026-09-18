" vim_aliases.vim - command aliases
" (vim_* convention: pure Vim config)

" Command aliases (command!: survives re-sourcing and collisions)
" W delegates to vim-eunuch :SudoWrite (RHS is resolved at invocation, so
" myvim loading before vim-eunuch is fine)
command! W SudoWrite
command! Q qa!