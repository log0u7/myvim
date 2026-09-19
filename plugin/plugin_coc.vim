" Plugin coc.nvim - LSP engine (successor of YouCompleteMe, retired 2026-09)
" Extensions auto-install on first start. Project settings go in
" .vim/coc-settings.json, global in ~/.config/coc/coc-settings.json.
" ALE coexistence: coc owns LSP, completion and diagnostics; ALE keeps the
" devops linters (ale_disable_lsp=1 is set in plugin_ale.vim). Silence ALE
" entirely if the dual gutter bothers you: let g:ale_enabled = 0
"
" Node runtime: coc needs node >= 20 (its bundle uses the RegExp v flag,
" ES2024) while the system node stays at 18. Preference order: an
" explicit g:coc_node_path in ~/.vim/vimrc, then the node managed by
" mise (`mise where node`, must resolve to >= 20), then the PATH node
" (also must be >= 20). When no valid runtime is found, warn loudly
" instead of letting coc spawn a service that dies on its first RegExp
" (silent 'abnormal exit with: 1').
function! s:node_major(node_bin) abort
  return str2nr(matchstr(trim(system(shellescape(a:node_bin) . ' --version')), '\d\+'))
endfunction

if !exists('g:coc_node_path')
  let s:mise_node = executable('mise')
        \ ? trim(system('mise where node 2>/dev/null')) : ''
  let s:mise_bin = s:mise_node !=# '' && filereadable(s:mise_node . '/bin/node')
        \ ? s:mise_node . '/bin/node' : ''
  if s:mise_bin !=# '' && s:node_major(s:mise_bin) >= 20
    let g:coc_node_path = s:mise_bin
  elseif s:node_major('node') < 20
    echom '[myvim] coc: no node >= 20 found'
          \ . (s:mise_bin !=# '' ? ' (mise node too old)' : ' (mise resolution failed)')
          \ . ' - coc will fail to start; set g:coc_node_path.'
  endif
  unlet! s:mise_node s:mise_bin
endif

let g:coc_global_extensions = [
      \   'coc-yaml',
      \   'coc-json',
      \   'coc-git',
      \   'coc-sh',
      \   'coc-docker',
      \   'coc-toml',
      \   '@yaegassy/coc-ansible',
      \   'coc-snippets',
      \   'coc-vimlsp',
      \ ]

" Generic LSP servers that have no coc extension (binary must be in PATH):
"   terraform-ls  https://github.com/hashicorp/terraform-ls
let g:coc_user_config = {
      \   'languageserver': {
      \     'terraform': {
      \       'command': 'terraform-ls',
      \       'args': ['serve'],
      \       'filetypes': ['terraform', 'hcl'],
      \       'rootPatterns': ['.terraform', '.git'],
      \     },
      \   },
      \ }

" Diagnostics navigation and LSP actions
" (nnoremap + <Cmd>: non-recursive, no jumplist/search-history pollution)
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gr <Plug>(coc-references)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> K <Cmd>call CocActionAsync('doHover')<CR>
nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> <leader>rn <Plug>(coc-rename)
nnoremap <silent> <leader>ca <Plug>(coc-codeaction-cursor)
nnoremap <silent> <leader>d <Cmd>CocList diagnostics<CR>
nnoremap <silent> <leader>o <Cmd>CocList outline<CR>