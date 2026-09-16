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
call s:check('undo/persistent config', &undodir =~# 'undodir' && &undofile)

" mappings
call s:check('NERDTree <F2> mapping', maparg('<F2>', 'n') =~# 'NERDTreeToggle')
call s:check('Minimap <F4> mapping', maparg('<F4>', 'n') =~# 'MinimapToggle')
call s:check('Undotree <F7> mapping', maparg('<F7>', 'n') =~# 'UndotreeToggle')
call s:check('fzf <leader>p mapping', maparg('<leader>p', 'n') =~# 'Files')

" plugins
call s:check('ALE command', exists(':ALEInfo') == 2)
call s:check('ALE lsp disabled', get(g:, 'ale_disable_lsp', 0) == 1)
call s:check('ALE yaml linters', get(get(g:, 'ale_linters', {}), 'yaml', []) == ['actionlint', 'yamllint'])
call s:check('CtrlP command', exists(':CtrlP') == 2)
call s:check('fzf :Files command', exists(':Files') == 2)
call s:check('Tagbar command', exists(':TagbarToggle') == 2)
call s:check('Vimwiki command', exists(':VimwikiIndex') == 2)
" gutentags (plugin loaded; buffer-local GutentagsUpdate needs a git
" project buffer and would kick off a ctags run in this smoke)
call s:check('Gutentags loaded', exists('g:loaded_gutentags') && g:loaded_gutentags == 1)
call s:check('tmux-navigator <C-h> mapping', maparg('<C-h>', 'n') =~# 'TmuxNavigateLeft')
call s:check('auto-pairs loaded', exists('g:AutoPairsFlyMode') || exists(':AutoPairsToggle') == 2)
call s:check('vim-ai :AI command', exists(':AI') == 2)
call s:check('coc.nvim loaded', exists(':CocInfo') == 2)
call s:check('coc node binary present', filereadable(expand(g:coc_node_path)))
call s:check('coc extensions declared', join(get(g:, 'coc_global_extensions', []), ',') =~# 'coc-yaml')

qa!