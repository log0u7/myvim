" Plugin vim-ai - AI assistant through OpenAI-compatible providers
" Default backend: LOCAL ollama (http://localhost:11434) with a micro
" completion model. Any OpenAI-compatible provider works: change
" endpoint_url + model (+ auth_type/token_file_path for cloud providers).
" Requires the ollama service: systemctl --user start ollama
"
" vim-ai defines its defaults in its own plugin file, which loads AFTER
" myvim (runtimepath order): overrides are therefore applied once on
" VimEnter, mutating the same dicts vim-ai keeps by reference.

let s:ai_options = {
      \   'model': 'qwen2.5-coder:1.5b',
      \   'endpoint_url': 'http://localhost:11434/v1/chat/completions',
      \   'auth_type': 'none',
      \   'request_timeout': 60,
      \ }

function! s:vim_ai_config() abort
  if exists('g:vim_ai_chat')
    for l:role in ['complete', 'edit', 'chat']
      execute 'let g:vim_ai_' . l:role . '.options = extend(g:vim_ai_' . l:role . '.options, s:ai_options)'
    endfor
  endif
endfunction

autocmd VimEnter * ++once call s:vim_ai_config()