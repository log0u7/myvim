" Plugin ALE - async linting (coc.nvim owns LSP; ALE lints only)
let g:ale_disable_lsp = 1
let g:ale_fix_on_save = 0

let g:ale_linters = {
      \   'ansible': ['ansible-lint'],
      \   'bash': ['shellcheck'],
      \   'dockerfile': ['hadolint'],
      \   'python': ['flake8'],
      \   'sh': ['shellcheck'],
      \   'terraform': ['tflint'],
      \   'yaml': ['yamllint'],
      \ }

" actionlint understands GitHub workflow files only: linting every yaml
" (compose, k8s, ansible, gitlab-ci) produced false errors. Workflow
" yamls get it buffer-locally, everything else stays yamllint-only.
augroup myvim_ale
  autocmd!
  autocmd FileType yaml
        \ if expand('<afile>:p') =~# '/\.github/workflows/'
        \ |   let b:ale_linters = ['actionlint', 'yamllint']
        \ | endif
augroup END
