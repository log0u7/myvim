" vim_filetypes.vim - custom filetype detection the Vim runtime lacks
"   - #cloud-config first line (cloud-init user-data, LXC/Packer/terraform
"     libvirt) -> yaml
"   - terragrunt.hcl -> terragrunt: its own filetype so terragrunt-ls can
"     attach without claiming every plain HCL file (vault policies,
"     terraform blocks stay 'hcl' and keep terraform-ls)
"   - LXC container config (/var/lib/lxc/*/config) -> sh (close enough:
"     # comments, key = value lines)
"
" The terragrunt rule hooks FileType=hcl, NOT BufRead: pack plugins load
" after the vimrc, so ftdetect files (vim-hcl and its unconditional
" `set filetype=hcl`) are sourced after this plugin; a BufRead rule
" defined here gets overridden. FileType handlers are defined once and
" fire whenever the hcl filetype lands, however late.
augroup myvim_filetypes
  autocmd!
  " First-line sniff: cloud-init user-data files usually have no
  " extension to detect from
  autocmd BufNewFile,BufRead *
        \ if getline(1) =~# '^#cloud-config' | set filetype=yaml | endif
  " <afile> is the buffer name for FileType; match the file tail
  autocmd FileType hcl
        \ if expand('<afile>:t') ==# 'terragrunt.hcl' | set filetype=terragrunt | endif
  autocmd BufRead */var/lib/lxc/*/config set filetype=sh
augroup END
