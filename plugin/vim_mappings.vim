" vim_mappings.vim - global key mappings
" One place to audit every binding. Plugin-local (buffer) mappings live in
" their plugin_*.vim or ftplugin/ files.

" IDE panels (F2-F6/F10 belong to vdebug inside a debug session:
" buffer-local mappings win there, F5 run, F4 step out, F6 close)
" <silent> is uniform across global maps (<Cmd> echoes nothing, the
" flag keeps the whole file consistent with the F8/coc maps).
nnoremap <silent> <F2> <Cmd>NERDTreeToggle<CR>
nnoremap <silent> <F3> <Cmd>PluginManagerToggle<CR>
nnoremap <silent> <F4> <Cmd>MinimapToggle<CR>
nnoremap <silent> <F9> <Cmd>call mouse_clip#toggle()<CR>
nnoremap <silent> <F7> <Cmd>UndotreeToggle<CR>

" Only autocmds live in the augroup (re-sourcing clears stale ones);
" plain mappings sit outside, idempotent by nature.
augroup myvim_mappings
  autocmd!

  " Markdown preview (markdown buffers only)
  autocmd FileType markdown nnoremap <buffer> <silent> <F8> <Cmd>MarkdownPreview<CR>
  autocmd FileType markdown inoremap <buffer> <silent> <F8> <Cmd>MarkdownPreview<CR>
augroup END

" fzf
nnoremap <silent> <C-p> <Cmd>Files<CR>
nnoremap <silent> <leader>p <Cmd>Files<CR>
nnoremap <silent> <leader>b <Cmd>Buffers<CR>
nnoremap <silent> <leader>g <Cmd>GFiles<CR>
