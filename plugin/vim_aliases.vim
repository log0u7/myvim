" vim_aliases.vim - command aliases
" (vim_* convention: pure Vim config)

" Command alias
command W w !sudo tee > /dev/null %
command Q qa!