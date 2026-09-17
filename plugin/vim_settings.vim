" vim_settings.vim - general editor options
" (loaded from the myvim plugin; essentials that MUST run before plugins
" stay in ~/.vim/vimrc)

set number
set hlsearch
set laststatus=2

" Swapfile Dir (trailing // = unique names, no basename collisions)
set directory^=~/.vim/swapdir//

" Persistent Undo
set undodir=~/.vim/undodir
set undofile

" Set diff algo to patience and indent heuristic
set diffopt+=algorithm:patience,indent-heuristic

" Command aliases live in vim_aliases.vim
