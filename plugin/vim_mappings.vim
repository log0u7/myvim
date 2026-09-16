" vim_mappings.vim - global key mappings
" One place to audit every binding. Plugin-local (buffer) mappings live in
" their plugin_*.vim or ftplugin/ files.

" IDE panels
nmap <F2> :NERDTreeToggle<CR>
nmap <F3> :PluginManagerToggle<CR>
nmap <F4> :MinimapToggle<CR>
nmap <F7> :UndotreeToggle<CR>

" Markdown preview (markdown buffers only)
autocmd FileType markdown nnoremap <buffer> <silent> <F8> :MarkdownPreview<CR>
autocmd FileType markdown inoremap <buffer> <silent> <F8> :MarkdownPreview<CR>

" fzf (ctrlp keeps <C-p> via its own default mapping)
nnoremap <leader>p :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>g :GFiles<CR>
