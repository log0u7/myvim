" Plugin ALE - async linting (coc.nvim owns LSP; ALE lints only)
" Formatting: fixers run ONLY on demand (`:ALEFix` / <leader>f);
" ale_fix_on_save stays 0 on purpose (surprise-free buffers).
let g:ale_disable_lsp = 1
let g:ale_fix_on_save = 0

let g:ale_linters = {
      \   'ansible': ['ansible-lint'],
      \   'bash': ['shellcheck'],
      \   'dockerfile': ['hadolint'],
      \   'nix': ['deadnix', 'statix'],
      \   'python': ['flake8'],
      \   'sh': ['shellcheck'],
      \   'terraform': ['tflint'],
      \   'xml': ['xmllint'],
      \   'yaml': ['yamllint'],
      \ }

let g:ale_fixers = {
      \   'bash': ['shfmt'],
      \   'nix': ['alejandra'],
      \   'sh': ['shfmt'],
      \   'terraform': ['terraform'],
      \ }

" kubeconform validates k8s manifests; ALE ships no linter for it.
" Scoped buffer-locally by the augroup below (apiVersion first line):
" compose, ansible and workflow yamls never run it. Reads stdin, like
" actionlint. No line numbers in its output: items anchor to the buffer.
function! s:kubeconform_handle(buffer, lines) abort
  let l:output = []
  try
    let l:data = json_decode(join(a:lines, ''))
  catch
    return l:output
  endtry
  for l:resource in get(l:data, 'resources', [])
    if get(l:resource, 'status') ==# 'statusValid'
      continue
    endif
    let l:text = join(map(copy(get(l:resource, 'validationErrors', [])), 'v:val.msg'), '; ')
    if l:text ==# ''
      let l:text = get(l:resource, 'msg', get(l:resource, 'status', 'invalid resource'))
    endif
    let l:kind = get(l:resource, 'kind', '')
    if l:kind !=# ''
      let l:text = l:kind . ': ' . l:text
    endif
    call add(l:output, {'lnum': 0, 'text': l:text, 'type': 'E'})
  endfor
  return l:output
endfunction

call ale#linter#Define('yaml', {
\   'name': 'kubeconform',
\   'executable': 'kubeconform',
\   'command': 'kubeconform -strict -ignore-missing-schemas -output json -',
\   'callback': function('s:kubeconform_handle'),
\   'output_stream': 'stdout',
\ })

" actionlint understands GitHub workflow files only: linting every yaml
" (compose, k8s, ansible, gitlab-ci) produced false errors. Workflow
" yamls get it buffer-locally, everything else stays yamllint-only.
" Same mechanism for kubeconform: a manifest starts with apiVersion;
" compose starts with services/version, plain yamls with anything else.
augroup myvim_ale
  autocmd!
  autocmd FileType yaml
        \ if expand('<afile>:p') =~# '/\.github/workflows/'
        \ |   let b:ale_linters = ['actionlint', 'yamllint']
        \ | elseif getline(1) =~# '^apiVersion:'
        \ |   let b:ale_linters = ['kubeconform', 'yamllint']
        \ | endif
augroup END
