" Smoke test for the myvim configuration plugin.
" Run against the LIVE install:  make smoke
" Exits 0 when every check passes, 1 on the first failure.

set nomore

function! s:check(name, expr) abort
  if a:expr
    echo 'PASS: ' . a:name
  else
    echo 'FAIL: ' . a:name
    call writefile(['FAIL: ' . a:name], '/tmp/myvim-smoke-fail.txt')
    cquit 1
  endif
endfunction

" manager
call s:check('PluginManager command', exists(':PluginManager') == 2)
call s:check('PluginManager <F3> mapping', maparg('<F3>', 'n') =~# 'PluginManagerToggle')

" myvim config modules loaded
call s:check('sidebar width configured (number)', exists('g:plugin_manager_sidebar_width') && type(g:plugin_manager_sidebar_width) == type(0))
call s:check('airline powerline config', exists('g:airline_powerline_fonts') && g:airline_powerline_fonts == 1)
call s:check('NERDTree menu config', exists('g:NERDTreeMinimalMenu') && g:NERDTreeMinimalMenu == 1)
" the VimEnter definition must carry the exists(':NERDTree') guard:
" NERDTree may be absent (E492) and VimEnter fires in git commit /
" crontab -e / sudoedit sessions too
call s:check('NERDTree VimEnter guarded', exists('#myvim_nerdtree#VimEnter') == 1 && execute('autocmd myvim_nerdtree VimEnter') =~# 'exists')
call s:check('undo/persistent config', &undodir =~# 'undodir' && &undofile && isdirectory(expand('~/.vim/undodir')))
call s:check('swapdir auto-created + prepended', isdirectory(expand('~/.vim/swapdir')) && &directory =~# 'swapdir')
" re-source with a decoy in front: undodir must be PREPENDED (^=), not
" overwritten (=) - a user-configured first entry has to survive
let &undodir = '/tmp/myvim-decoy//'
execute 'source' fnameescape(expand('~/.vim/pack/plugins/start/myvim/plugin/vim_settings.vim'))
call s:check('undodir prepended (user value kept)', &undodir =~# 'myvim-decoy')

" mappings
call s:check('NERDTree <F2> mapping', maparg('<F2>', 'n') =~# 'NERDTreeToggle')
call s:check('Undotree <F7> mapping', maparg('<F7>', 'n') =~# 'UndotreeToggle')
call s:check('fzf <C-p> mapping', maparg('<C-p>', 'n') =~# 'Files')
call s:check('fzf <leader>p mapping', maparg('<leader>p', 'n') =~# 'Files')
" every global map goes through <Cmd> (no echo anyway): <silent> stays
" uniform with the F8/coc maps instead of half the file having it
let s:silent_ok = 1
for s:k in ['<F2>', '<F3>', '<F4>', '<F9>', '<F7>', '<C-p>', '<leader>p', '<leader>b', '<leader>g']
  let s:silent_ok = s:silent_ok && get(maparg(s:k, 'n', 0, 1), 'silent', 0)
endfor
call s:check('global maps <silent>', s:silent_ok)

" plugins
call s:check('ALE command', exists(':ALEInfo') == 2)
call s:check('ALE lsp disabled', get(g:, 'ale_disable_lsp', 0) == 1)
call s:check('ALE yaml linters', get(get(g:, 'ale_linters', {}), 'yaml', []) == ['yamllint'])
" actionlint understands GitHub workflow files only: a workflow yaml
" gets it buffer-locally, every other yaml must not see it globally
call mkdir('/tmp/myvim-smoke-ghwf/.github/workflows', 'p')
call writefile(['on: push'], '/tmp/myvim-smoke-ghwf/.github/workflows/ci.yml')
split /tmp/myvim-smoke-ghwf/.github/workflows/ci.yml
call s:check('actionlint on GH workflow yaml', get(b:, 'ale_linters', []) == ['actionlint', 'yamllint'])
q!
call s:check('fzf :Files command', exists(':Files') == 2)
call s:check('Tagbar command', exists(':TagbarToggle') == 2)
call s:check('Vimwiki command', exists(':VimwikiIndex') == 2)
" gutentags (plugin loaded; buffer-local GutentagsUpdate needs a git
" project buffer and would kick off a ctags run in this smoke)
call s:check('Gutentags loaded', exists('g:loaded_gutentags') && g:loaded_gutentags == 1)
call s:check('tmux-navigator <C-h> mapping', maparg('<C-h>', 'n') =~# 'TmuxNavigateLeft')
call s:check('vim-ai :AI command', exists(':AI') == 2)
" the placeholder domains dict must stay commented until real values
" exist (a fake domain feeds :GBrowse a dead web view)
call s:check('fugitive placeholder domains commented', !exists('g:fugitive_gitlab_domains'))
call s:check('minimap <F4> mapping', maparg('<F4>', 'n') =~# 'MinimapToggle')
call s:check('minimap :MinimapToggle command', exists(':MinimapToggle') == 2)
call s:check('mouse toggle <F9> mapping', maparg('<F9>', 'n') =~# 'mouse_clip#toggle')
let s:mouse_before = &mouse
call mouse_clip#toggle()
call s:check('mouse toggle flips mouse option', &mouse !=# s:mouse_before)
call mouse_clip#toggle()
call s:check('OSC52 yank autocmd registered', exists('#myvim_mouse_clip#TextYankPost') == 1)
" OSC52 helpers live in autoload/mouse_clip.vim (smoke-testable). The
" try/catch keeps installs without them fail-visible instead of raising
" E117 mid-suite (exists() returns 0 for not-yet-loaded autoload
" functions, so the call itself is the presence test).
let s:osc_ok = 0
try
  let s:osc_ok = mouse_clip#encode('hello') ==# 'aGVsbG8='
catch
endtry
call s:check('OSC52 encoder + payload', s:osc_ok)
call s:check('OSC52 cap counts bytes', mouse_clip#encode(repeat("\u00e9", 60000)) ==# '')
call s:check('OSC52 opt-out default on', mouse_clip#enabled() == 1)
let g:myvim_osc52 = 0
call s:check('OSC52 opt-out gate', mouse_clip#enabled() == 0)
unlet g:myvim_osc52
call s:check('coc.nvim loaded', exists(':CocInfo') == 2)
call s:check('coc node binary present', !exists('g:coc_node_path') || filereadable(expand(g:coc_node_path)))
" resolution is machine-dependent: it must conclude either way (cached
" path or loud warning), never leave coc to spawn a dying service
call s:check('coc node resolution concluded', exists('g:coc_node_path') == 1 || stridx(execute('messages'), 'no node >= 20') >= 0)
call s:check('coc extensions declared', join(get(g:, 'coc_global_extensions', []), ',') =~# 'coc-yaml')
call s:check('coc-snippets extension declared', join(get(g:, 'coc_global_extensions', []), ',') =~# 'coc-snippets')

" aliases, doc and remaining wiring
call s:check('aliases W and Q', exists(':W') == 2 && exists(':Q') == 2)
" Q must refuse to quit on modified buffers (plain qa), not discard them
call s:check('Q confirm (no bang)', execute('command Q') =~# '\<qa\>' && execute('command Q') !~# 'qa!')
call s:check('eunuch SudoWrite (W delegates)', exists(':SudoWrite') == 2)
call s:check('coc gd mapping', maparg('gd', 'n') =~# 'coc-definition')
call s:check('coc K hover mapping', maparg('K', 'n') =~# 'doHover')
call s:check('markdown F8 autocmd registered', exists('#FileType#markdown') == 1)
call s:check('vim-ai roles.ini readable', filereadable(g:vim_ai_roles_config_file))
call s:check('manager vimrc path configured', exists('g:plugin_manager_vimrc_path'))
call s:check('help file + tags present', filereadable(expand('~/.vim/pack/plugins/start/myvim/doc/myvim.txt')) && filereadable(expand('~/.vim/pack/plugins/start/myvim/doc/tags')))

qa!