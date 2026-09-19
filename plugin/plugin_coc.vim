" Plugin coc.nvim - LSP engine (successor of YouCompleteMe, retired 2026-09)
" Extensions auto-install on first start. Project settings go in
" .vim/coc-settings.json, global in ~/.config/coc/coc-settings.json.
" ALE coexistence: coc owns LSP, completion and diagnostics; ALE keeps the
" devops linters (ale_disable_lsp=1 is set in plugin_ale.vim). Silence ALE
" entirely if the dual gutter bothers you: let g:ale_enabled = 0
"
" Node runtime: coc needs node >= 20 (its bundle uses the RegExp v flag,
" ES2024) while the system node stays at 18. Resolution order (first
" match wins; the outcome is cached in g:coc_node_path so re-sourcing
" skips the subprocesses): $COC_NODE_PATH, an explicit g:coc_node_path
" (checked before this block), the mise-managed node (`mise where node`),
" then the PATH node - all must resolve to >= 20. When nothing does,
" warn loudly WITH the reason instead of letting coc spawn a service
" that dies on its first RegExp (silent 'abnormal exit with: 1').
function! s:node_major(node_bin) abort
  return str2nr(matchstr(trim(system(shellescape(a:node_bin) . ' --version 2>/dev/null')), '\d\+'))
endfunction

if !exists('g:coc_node_path')
  if !empty($COC_NODE_PATH) && filereadable($COC_NODE_PATH)
    let g:coc_node_path = $COC_NODE_PATH
  else
    let s:mise_node = executable('mise')
          \ ? trim(system('mise where node 2>/dev/null')) : ''
    let s:mise_bin = s:mise_node !=# '' && filereadable(s:mise_node . '/bin/node')
          \ ? s:mise_node . '/bin/node' : ''
    let s:path_node = exepath('node')
    let s:path_major = s:path_node !=# '' ? s:node_major(s:path_node) : 0
    if s:mise_bin !=# '' && s:node_major(s:mise_bin) >= 20
      let g:coc_node_path = s:mise_bin
    elseif s:path_node !=# '' && s:path_major >= 20
      let g:coc_node_path = s:path_node
    else
      if !executable('mise') && s:path_node ==# ''
        let s:why = 'no node in PATH and mise absent'
      elseif !executable('mise')
        let s:why = 'system node ' . s:path_major . ' < 20'
      elseif s:mise_bin ==# ''
        let s:why = 'mise node resolution failed'
      else
        let s:why = 'mise node ' . s:node_major(s:mise_bin) . ' < 20'
      endif
      echom '[myvim] coc: no node >= 20 found (' . s:why . ')'
            \ . ' - coc will fail to start; set $COC_NODE_PATH or g:coc_node_path.'
    endif
    unlet! s:mise_node s:mise_bin s:path_node s:path_major s:why
  endif
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