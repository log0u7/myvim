" vim_colorscheme.vim - colorscheme selection
" Default: no colorscheme (the terminal palette applies).
"
" Truecolor terminals get 24-bit colors automatically (tokyonight / onedark
" degrade badly on 256-color terminals without it). Terminals without
" COLORTERM keep the 256-color fallback.
if $COLORTERM =~# 'truecolor\|24bit'
  set termguicolors
endif
"
" To activate one:
"   1. uncomment its Plugin line in ~/.vim/vimrc
"      (solarized / gruvbox8 / tokyonight / onedark)
"   2. uncomment the matching call below
"   3. restart vim

" solarized (termguicolors set above on truecolor terminals)
"set termguicolors
"colorscheme solarized

" gruvbox8 / tokyonight / onedark
"colorscheme gruvbox8
"colorscheme tokyonight
"colorscheme onedark
