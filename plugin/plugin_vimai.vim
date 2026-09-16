" Plugin vim-ai - AI assistant through OpenAI-compatible providers
" Default backend: LOCAL ollama (http://localhost:11434) with a micro
" completion model, configured through roles (see roles.ini next to this
" plugin). Any OpenAI-compatible provider works: change options.endpoint_url
" + options.model in roles.ini (+ token_file_path for cloud providers).
" Requires the ollama service: systemctl --user start ollama

let g:vim_ai_roles_config_file = expand('<script>:p:h:h') . '/roles.ini'