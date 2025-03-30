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

" Mapleader (nmap<leader>w :w!<cr>) 
"let mapleader = "\"
"let g:mapleader = "\"

" Command alias
command W w !sudo tee > /dev/null %
command Q qa!

"" NERDTree
" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

let NERDTreeShowBookmarks = 1   		" Show the bookmarks table
let NERDTreeShowHidden = 1      		" Show hidden files
let NERDTreeShowLineNumbers = 0 		" Hide line numbers
let NERDTreeMinimalMenu = 1     		" Use the minimal menu (m)
let NERDTreeWinPos = 'left'     		" Panel opens on the left side
let NERDTreeWinSize = 31        		" Set panel width to 31 columns
let NERDTreeIgnore=['\.git$','.swp$']		" Ignore somme files and directories

nmap <F2> :NERDTreeToggle<CR>

"" TagBar
let g:tagbar_autofocus = 1 			" Focus the panel when opening it
let g:tagbar_autoshowtag = 1			" Highlight the active tag
let g:tagbar_position = 'botright vertical' 	" Make panel vertical and place on the right

nmap <F3> :TagbarToggle<CR>

"" Minimap
"let g:minimap_show='<leader>ms'
"let g:minimap_update='<leader>mu'
"let g:minimap_close='<leader>gc'
"let g:minimap_toggle='<leader>gt'
"let g:minimap_highlight='Visual'

nmap <F4> :MinimapToggle<CR>

"" BufExplorer
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'

"" CtrlP
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.git\|.swp'

"" Fugitive
let g:fugitive_gitlab_domains = {'ssh://git.private.gilab.domain.tld': 'https://gitlab.domain.tld'}
let g:gitlab_api_keys = {'gitlab.com': 'mytoken1', 'gitlab.domain.tld': 'mytoken2' }

"" Undotree
let g:undotree_WindowLayout = 3

nmap <F7> :UndotreeToggle<CR>

"" Markdown Preview
let g:mkdp_path_to_chrome = ""
let g:mkdp_browserfunc = 'MKDP_browserfunc_default'
let g:mkdp_auto_start = 0
let g:mkdp_auto_open = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0

autocmd FileType markdown nnoremap <buffer> <silent> <F8> :MarkdownPreview<CR>
autocmd FileType markdown inoremap <buffer> <silent> <F8> :MarkdownPreview<CR>
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

"" Airline
let g:airline_powerline_fonts = 1
