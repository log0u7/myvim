" vim_mappings.vim - global key mappings
" One place to audit every binding. Plugin-local (buffer) mappings live in
" their plugin_*.vim or ftplugin/ files.

augroup myvim_mappings
  autocmd!

  " IDE panels
  nnoremap <F2> <Cmd>NERDTreeToggle<CR>
  nnoremap <F3> <Cmd>PluginManagerToggle<CR>
  nnoremap <F4> <Cmd>MinimapToggle<CR>
  nnoremap <F7> <Cmd>UndotreeToggle<CR>

  " Markdown preview (markdown buffers only)
  autocmd FileType markdown nnoremap <buffer> <silent> <F8> <Cmd>MarkdownPreview<CR>
  autocmd FileType markdown inoremap <buffer> <silent> <F8> <Cmd>MarkdownPreview<CR>
augroup END

" fzf (ctrlp keeps <C-p> via its own default mapping)
nnoremap <leader>p <Cmd>Files<CR>
nnoremap <leader>b <Cmd>Buffers<CR>
nnoremap <leader>g <Cmd>GFiles<CR>
