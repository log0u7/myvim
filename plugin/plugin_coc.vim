" Plugin coc.nvim - LSP engine (successor of YouCompleteMe, retired 2026-09)
" Extensions auto-install on first start. Project settings go in
" .vim/coc-settings.json, global in ~/.config/coc/coc-settings.json.
" ALE coexistence: coc owns LSP, completion and diagnostics; ALE keeps the
" devops linters (ale_disable_lsp=1 is set in plugin_ale.vim). Silence ALE
" entirely if the dual gutter bothers you: let g:ale_enabled = 0
"
" Node runtime: coc needs node >= 20 (its bundle uses the RegExp v flag,
" ES2024) while the system node stays at 18. The node 22 install managed by
" mise is pinned here; bump the path after `mise install node@<newer>`.

let g:coc_node_path = expand('~/.local/share/mise/installs/node/22.23.2/bin/node')

let g:coc_global_extensions = [
      \   'coc-yaml',
      \   'coc-json',
      \   'coc-git',
      \   'coc-sh',
      \   'coc-docker',
      \   'coc-toml',
      \   'coc-ansible',
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