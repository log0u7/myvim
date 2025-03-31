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