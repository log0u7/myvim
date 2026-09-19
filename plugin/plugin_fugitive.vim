" Fugitive
" Placeholder domains - enable (uncomment) only with real values, a
" fake domain feeds :GBrowse a dead web view:
" let g:fugitive_gitlab_domains = {'ssh://git.private.gitlab.domain.tld': 'https://gitlab.domain.tld'}

" NEVER commit real API tokens. Put them in a gitignored file instead:
"   ~/.vim/plugin/fugitive-secrets.vim  (add "plugin/*-secrets.vim" to ~/.vim/.gitignore)
" Example content:
"   let g:gitlab_api_keys = {'gitlab.com': 'YOURTOKEN', 'gitlab.domain.tld': 'YOURTOKEN'}
" let g:gitlab_api_keys = {'gitlab.com': 'mytoken1', 'gitlab.domain.tld': 'mytoken2'}
