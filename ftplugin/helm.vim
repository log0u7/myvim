" ftplugin/helm.vim - yaml-style settings for Helm chart templates
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

setlocal ts=2 sts=2 sw=2 expandtab

let b:undo_ftplugin = 'setlocal ts< sts< sw< et<'
