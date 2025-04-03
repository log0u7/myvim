"" Markdown Preview
 let g:mkdp_path_to_chrome = ""
 let g:mkdp_browserfunc = 'MKDP_browserfunc_default'
 let g:mkdp_auto_start = 0
 let g:mkdp_auto_open = 0
 let g:mkdp_auto_close = 1
 let g:mkdp_refresh_slow = 0
 let g:mkdp_command_for_global = 0
 let g:mkdp_open_to_the_world = 0
 
 autocmd FileType markdown nnoremap <buffer> <silent> <F8> :MarkdownPreview<CR>
 autocmd FileType markdown inoremap <buffer> <silent> <F8> :MarkdownPreview<CR>
 autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
