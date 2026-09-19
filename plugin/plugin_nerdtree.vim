" Plugin NERDTree
" Start NERDTree. If a file is specified, move the cursor to its window.
augroup myvim_nerdtree
  autocmd!

  autocmd StdinReadPre * let s:std_in=1
  " Guarded: NERDTree may be absent (E492) and VimEnter fires in git
  " commit / crontab -e / sudoedit sessions too.
  autocmd VimEnter * if exists(':NERDTree') == 2
        \ | NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
        \ | endif
  " Close the tab if NERDTree is the only window remaining in it; when this
  " tab is the only tab, quitting the last window exits Vim.
  autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
augroup END

let NERDTreeShowBookmarks = 1   " Show the bookmarks table
let NERDTreeShowHidden = 1      " Show hidden files
let NERDTreeShowLineNumbers = 0 " Hide line numbers
let NERDTreeMinimalMenu = 1     " Use the minimal menu (m)
let NERDTreeWinPos = 'left'     " Panel opens on the left side
let NERDTreeWinSize = 31        " Set panel width to 31 columns
" Ignore some files and directories
let NERDTreeIgnore=['\.git$','\.swp$']
