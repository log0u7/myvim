" essentials: must run before plugin/*.vim load
syn on
filetype plugin indent on
set nocompatible
set encoding=UTF-8
set background=dark
" Mapleader must be defined before plugins load ! (default '\', uncomment to change)
"let mapleader = '\'

" Plugins managed by vim-plugin-manager (Git submodules + native packages)
packadd vim-plugin-manager
PluginBegin
  " --- basics / UI ---
  Plugin 'tpope/vim-sensible'
  Plugin 'tpope/vim-sleuth'
  Plugin 'chrisbra/matchit'
  Plugin 'vim-airline/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'
  Plugin 'edkolev/tmuxline.vim'
  Plugin 'wincent/terminus'
  Plugin 'ryanoasis/vim-devicons'
  Plugin 'Yggdroot/indentLine'
  Plugin 'ludovicchabant/vim-gutentags'
  Plugin 'christoomey/vim-tmux-navigator'
  " --- navigation / IDE panels ---
  Plugin 'preservim/nerdtree'
  Plugin 'Xuyuanp/nerdtree-git-plugin'
  Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plugin 'preservim/tagbar'
  Plugin 'junegunn/fzf', {'dir': 'fzf', 'exec': './install --all'}
  Plugin 'junegunn/fzf.vim'
  Plugin 'jlanzarotta/bufexplorer'
  Plugin 'mbbill/undotree'
  Plugin 'severin-lemaignan/vim-minimap'
  " --- completion / LSP (coc.nvim replaced YouCompleteMe) ---
  Plugin 'neoclide/coc.nvim', {'branch': 'release'}
  Plugin 'honza/vim-snippets'
  Plugin 'SirVer/ultisnips'
  " --- linting (async; replaces syntastic) ---
  Plugin 'dense-analysis/ale'
  " --- git ---
  Plugin 'tpope/vim-fugitive'
  Plugin 'shumphrey/fugitive-gitlab.vim'
  Plugin 'mhinz/vim-signify'
  Plugin 'tpope/vim-eunuch'
  Plugin 'tpope/vim-dispatch'
  " --- terminal / debug ---
  Plugin 'voldikss/vim-floaterm'
  Plugin 'vim-vdebug/vdebug'
  " --- devops syntax ---
  Plugin 'pearofducks/ansible-vim'
  Plugin 'saltstack/salt-vim'
  Plugin 'hashivim/vim-hashicorp-tools'
  Plugin 'jvirtanen/vim-hcl'
  Plugin 'Glench/Vim-Jinja2-Syntax'
  Plugin 'LnL7/vim-nix'
  " --- ai (local ollama via OpenAI-compatible API; optional: copilot, codeium) ---
  Plugin 'madox2/vim-ai'
  Plugin 'github/copilot.vim', {'load': 'opt'}
  Plugin 'Exafunction/codeium.vim', {'load': 'opt'}
  " --- docs / notes ---
  Plugin 'iamcco/markdown-preview.nvim'
  Plugin 'vimwiki/vimwiki'
  " --- personal configuration plugin (loads last) ---
  Plugin 'log0u7/myvim'
PluginEnd
