" syntax/helm.vim - Helm chart templates are (mostly) yaml
" Alias: reuse the builtin yaml syntax; template braces stay plain text,
" helm_ls (LSP) handles template semantics.
if !exists('b:current_syntax')
  runtime! syntax/yaml.vim
endif
