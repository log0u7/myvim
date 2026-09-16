" Plugin ALE - async linting (YCM owns LSP; ALE lints only)
let g:ale_disable_lsp = 1
let g:ale_fix_on_save = 0

let g:ale_linters = {
      \   'ansible': ['ansible-lint'],
      \   'bash': ['shellcheck'],
      \   'dockerfile': ['hadolint'],
      \   'python': ['flake8'],
      \   'sh': ['shellcheck'],
      \   'terraform': ['tflint'],
      \   'yaml': ['actionlint', 'yamllint'],
      \ }
