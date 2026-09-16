" vim_settings.vim - general editor options
" (loaded from the myvim plugin; essentials that MUST run before plugins
" stay in ~/.vim/vimrc)

set nu
set nopaste
set hlsearch
set laststatus=2

" Swapfile Dir
set directory^=$HOME/.vim/swapdir/

" Persistent Undo
set undodir=~/.vim/undodir
set undofile

" Set diff algo to patience and indent heuristic
set diffopt+=algorithm:patience,indent-heuristic

" Command alias
command W w !sudo tee > /dev/null %
command Q qa!
