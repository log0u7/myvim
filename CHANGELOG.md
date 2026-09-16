# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2026-09-16

### Added

- Modular configuration layout: `plugin/vim_*.vim` (pure Vim config:
  settings, mappings, colorscheme mechanism) and `plugin/plugin_*.vim`
  (per-plugin configuration, one file per plugin)
- `vim_mappings.vim`: all global key mappings centralized (F2 NERDTree,
  F3 Plugin Manager, F4 Minimap, F7 Undotree, F8 Markdown Preview,
  fzf leader mappings)
- `vim_colorscheme.vim`: colorscheme activation mechanism (no colorscheme
  forced by default)
- `plugin_ale.vim`: ALE linting with devops linters per filetype
  (ansible-lint, shellcheck, hadolint, flake8, tflint, actionlint, yamllint),
  LSP left to YouCompleteMe (`ale_disable_lsp`)
- `plugin_gutentags.vim`: ctags exclusions
- `ftplugin/yaml.vim`: 2-space indentation
- `doc/myvim.txt`: in-editor documentation (`:help myvim`)
- New plugins: auto-pairs, gutentags, tmux-navigator

### Changed

- `~/.vim/vimrc` reduced to what must run before plugins load
  (mapleader, encoding, filetype, syntax) plus the declarative plugin list;
  general settings moved to `plugin/vim_settings.vim`

### Fixed

- gutentags canonical repository is `ludovicchabant/vim-gutentags`
  (`tpope/vim-gutentags` returns 404)

### Removed

- The old full-config layout (whole `~/.vim` + plugins as nested submodules
  in this repository); preserved at tag `legacy-full-config`
