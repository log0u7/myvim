" Plugin vim-ai - AI assistant through OpenAI-compatible providers
" Default backend: LOCAL ollama (http://localhost:11434) with a micro
" completion model. Any OpenAI-compatible provider works: change
" endpoint_url + model (+ auth_type/token_file_path for cloud providers).
" Requires the ollama service: systemctl --user start ollama

let s:ai_endpoint = 'http://localhost:11434/v1/chat/completions'
let s:ai_model = 'qwen2.5-coder:1.5b'

let s:ai_options = {
      \   'model': s:ai_model,
      \   'endpoint_url': s:ai_endpoint,
      \   'auth_type': 'none',
      \   'request_timeout': 60,
      \ }

let g:vim_ai_complete = {
      \   'provider': 'openai',
      \   'prompt': '',
      \   'options': extend(copy(g:vim_ai_complete.options), s:ai_options),
      \ }
let g:vim_ai_edit = {
      \   'provider': 'openai',
      \   'prompt': '',
      \   'options': extend(copy(g:vim_ai_edit.options), s:ai_options),
      \ }
let g:vim_ai_chat = {
      \   'provider': 'openai',
      \   'options': extend(copy(g:vim_ai_chat.options), s:ai_options),
      \ }