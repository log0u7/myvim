" Plugin coc.nvim - LSP engine (successor of YouCompleteMe, retired 2026-09)
" Extensions auto-install on first start. Project settings go in
" .vim/coc-settings.json, global in ~/.config/coc/coc-settings.json.
" ALE coexistence: coc owns LSP, completion and diagnostics; ALE keeps the
" devops linters (ale_disable_lsp=1 is set in plugin_ale.vim). Silence ALE
" entirely if the dual gutter bothers you: let g:ale_enabled = 0
"
" Node runtime: coc needs node >= 20 (its bundle uses the RegExp v flag,
" ES2024) while the system node stays at 18. The node managed by mise is
" resolved at startup (`mise where node`, default install, must be >= 20);
" a g:coc_node_path set in ~/.vim/vimrc wins. Without mise, coc falls back
" to the `node` binary in PATH.
if !exists('g:coc_node_path') && executable('mise')
  let s:mise_node = trim(system('mise where node 2>/dev/null'))
  if !v:shell_error && s:mise_node !=# '' && filereadable(s:mise_node . '/bin/node')
        \ && str2nr(matchstr(trim(system(s:mise_node . '/bin/node --version')), '\d\+')) >= 20
    let g:coc_node_path = s:mise_node . '/bin/node'
  endif
  unlet! s:mise_node
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