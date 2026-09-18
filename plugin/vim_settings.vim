" vim_settings.vim - general editor options
" (loaded from the myvim plugin; essentials that MUST run before plugins
" stay in ~/.vim/vimrc)

set number
set hlsearch
set laststatus=2

" Swapfile Dir (trailing // = unique names, no basename collisions)
" Dirs are created on first start (0700: swapfiles can hold sensitive text).
if !isdirectory(expand('~/.vim/swapdir'))
  call mkdir(expand('~/.vim/swapdir'), 'p', 0700)
endif
set directory^=~/.vim/swapdir//

" Persistent Undo
if !isdirectory(expand('~/.vim/undodir'))
  call mkdir(expand('~/.vim/undodir'), 'p', 0700)
endif
set undodir=~/.vim/undodir
set undofile

" Set diff algo to patience and indent heuristic
set diffopt+=algorithm:patience,indent-heuristic

" Command aliases live in vim_aliases.vim
