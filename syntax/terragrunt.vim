" syntax/terragrunt.vim - terragrunt.hcl files speak HCL
" Alias: reuse the HCL syntax from jvirtanen/vim-hcl.
if !exists('b:current_syntax')
  runtime! syntax/hcl.vim
endif
