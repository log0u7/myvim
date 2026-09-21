" ftplugin/terragrunt.vim - HCL-style settings for terragrunt.hcl files
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

setlocal ts=2 sts=2 sw=2 expandtab
setlocal commentstring=#\ %s

let b:undo_ftplugin = 'setlocal ts< sts< sw< et< commentstring<'
