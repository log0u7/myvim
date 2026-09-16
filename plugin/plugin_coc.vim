" Plugin coc.nvim - LSP engine (successor of YouCompleteMe, retired 2026-09)
" Extensions auto-install on first start. Project settings go in
" .vim/coc-settings.json, global in ~/.config/coc/coc-settings.json.
" ALE coexistence: coc owns LSP, completion and diagnostics; ALE keeps the
" devops linters (ale_disable_lsp=1 is set in plugin_ale.vim). Silence ALE
" entirely if the dual gutter bothers you: let g:ale_enabled = 0

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
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> K :call CocActionAsync('doHover')<CR>
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ca <Plug>(coc-codeaction-cursor)
nnoremap <silent> <leader>d :CocList diagnostics<CR>
nnoremap <silent> <leader>o :CocList outline<CR>