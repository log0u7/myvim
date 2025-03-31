syn on
filetype plugin indent on
"colorscheme solarized

set nu
set nopaste
set background=dark
set encoding=UTF-8
set hlsearch
set nocompatible
set laststatus=2

"set t_Co=256
"let g:solarized_termcolors=256

" Swapfile Dir
set directory^=$HOME/.vim/swapdir/

" Peristent Undo
set undodir=~/.vim/undodir
set undofile

" Set diff algo to patience and indent heuristic
set diffopt+=algorithm:patience,indent-heuristic

" Mapleader (nmap<leader>w :w!<cr>) 
"let mapleader = "\"
"let g:mapleader = "\"

" Command alias
command W w !sudo tee > /dev/null %
command Q qa!