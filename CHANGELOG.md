# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- `coc-snippets` extension declared (`g:coc_global_extensions`): the
  UltiSnips/vim-snippets snippets are now visible in the coc completion
  (bridge was missing: snippets installed but unreachable from coc)
- `<C-p>` mapped to fzf `:Files` (reflex preserved after CtrlP removal)
- `swapdir/` and `undodir/` created automatically at first start
  (`mkdir` mode 0700: swapfiles can hold sensitive text); no more manual
  `mkdir -p` in the `~/.vim` quickstart
- Truecolor detection: `termguicolors` set automatically when `$COLORTERM`
  announces 24-bit support (tokyonight/onedark degraded without it);
  obsolete `t_Co=256`/`solarized_termcolors` dropped from the solarized
  activation block

### Changed

- `W` command alias delegates to the vim-eunuch `:SudoWrite` instead of
  the hand-rolled `w !sudo tee` (eunuch was installed and unused here)
- Node runtime: the hard pin `g:coc_node_path` on
  `~/.local/share/mise/installs/node/22.23.2/bin/node` is replaced by a
  startup resolution of the mise-managed node (`mise where node`, default
  install) when the resolved version is >= 20; `g:coc_node_path` set in
  the vimrc still wins; PATH node remains the no-mise fallback
- vim-go unpinned (was `v1.29`, 2023)
- Mappings sweep: non-recursive `nnoremap` + `<Cmd>` execution
  (vim_mappings.vim, plugin_coc.vim), `<silent>` made consistent
- Autocmds wrapped in augroups (myvim_mappings, myvim_nerdtree)
- ftplugin/yaml.vim: standard `b:did_ftplugin` guard + `b:undo_ftplugin`
- Swapfiles get unique names (`directory` trailing `//`), obsolete
  `set nopaste` dropped, `set number` spelling, `$HOME` -> `~` idiom
- Comment style unified (`" Plugin X` headers, spaces before trailing
  comments), 3x duplicated mapping-pointer comments removed

### Removed

- Dead/abandoned plugins (submodules of `~/.vim` + declarative lines):
  vim-bufferline (~2017, airline covers the tabline), auto-pairs
  (abandoned 2019), vim-virtualenv (~2015), Dockerfile.vim (stale,
  coc-docker covers), vim-minimap (stale)
- CtrlP (doublon: fzf covers files/buffers/git; CtrlP was a kept-alive
  fork) + config stubs `plugin_ctrlp.vim` and `plugin_minimap.vim`

### Fixed

- Stale ALE header comment ("YCM owns LSP"; YCM retired 2026-09, coc
  owns LSP)
- README quickstart `mapleader` example was a shell-escape trap
  (`"let mapleader = "\"`: the backslash escapes the closing quote, the
  leader would silently become `"`); now `"let mapleader = '\'`
  (README snippet + live vimrc kept byte-identical)
- doc/myvim.txt: vim_settings.vim no longer described as owning the
  commands (moved to vim_aliases.vim in 0.2.0)
- Fugitive placeholder hostname typo (`gilab` -> `gitlab`, inert example
  for a future private instance; gitlab.com itself needs no config)
- Insert-mode `<F8>` typed `:MarkdownPreview<CR>` as text instead of
  running the command (`<Cmd>` fix)
- Smoke suite aborted with E121 instead of failing cleanly when
  `g:coc_node_path` is unset
- CtrlP/NERDTree ignore patterns: unescaped `.swp` matched any `Xswp`
- `command W/Q` raised E174 on re-source (missing `command!` bang)
- Dead NERDTree exit autocmd removed (strict subset of the tab-close
  autocmd; the only-tab case still exits Vim, verified empirically)

### Tests

- Smoke suite re-balanced (count maintained at 31): Minimap `<F4>`, CtrlP
  and auto-pairs checks dropped with their plugins; new checks: fzf
  `<C-p>` mapping, coc-snippets declared, eunuch `:SudoWrite` present,
  undodir auto-created; `coc node binary present` now tolerant (skips
  when `g:coc_node_path` is unset)
- Smoke suite: 7 new checks in the previous audit round (W/Q aliases,
  coc `gd`/`K` mappings, markdown F8 autocmd, roles.ini readable,
  manager vimrc path, help file + tags)

### Documentation

- README: PluginBegin block pruned (6 dead plugins, vim-go unpinned,
  `mkdir -p` dropped), mappings table (`<F4>` out, `<C-p>` = fzf Files),
  module table (`W` = `:SudoWrite`, node resolution), Node runtime
  section rewritten (mise resolution, custom-node override), colorscheme
  section notes auto `termguicolors`
- doc/myvim.txt: same topics resynchronized (mappings, node runtime,
  coc extensions, aliases); structure list completed (vim_aliases.vim,
  plugin_pluginmanager.vim), `<Cmd>` mapping style documented
- CHANGELOG [0.2.0]: smoke check count corrected (22 -> 24, as released)

## [0.2.0] - 2026-09-16

### Added

- coc.nvim replaces YouCompleteMe as LSP engine: `plugin_coc.vim` declares
  the extensions (`g:coc_global_extensions`: yaml, json, git, sh, docker,
  toml, ansible, vimlsp), the generic `terraform-ls` server
  (`g:coc_user_config`) and the LSP mappings (gd/gr/gi/K, [g/]g,
  <leader>rn/ca/d/o). README: coc section, mappings table, YCM farewell
- `plugin_vimai.vim`: AI assistant via vim-ai, default backend is the LOCAL
  ollama server (OpenAI-compatible endpoint `http://localhost:11434`, model
  `qwen2.5-coder:1.5b`); any OpenAI-compatible provider works by changing
  `endpoint_url`/`model`. Configured through `roles.ini` (supported
  mechanism, no `g:vim_ai_*` dicts)
- Node runtime pin: `g:coc_node_path` points coc at the mise node 22
  install (coc needs node >= 20, RegExp `v` flag); the system node stays 18
- `plugin/vim_aliases.vim`: command aliases (`W`, `Q`) moved out of
  `vim_settings.vim` (vim_* convention: one module per concern)
- `tests/smoke.vim` + `make smoke`: smoke suite against the live install
  (24 checks: modules loaded, mappings wired, plugin commands present,
  coc node binary pinned); exits non-zero on the first failure. Caught two
  real issues on its first run (coc client crash on node 18, gutentags
  buffer-local commands)
- `Makefile` for the smoke target
- README rebuilt (Diátaxis: Quickstart, How-to, Reference, Explanation):
  badges (vim 8.2+, MIT, vim-plugin-manager), MIT LICENSE, complete module
  layout table (vim_aliases, coc, vimai, roles.ini, tests, Makefile),
  node runtime section, coc mappings table, YCM both-install-paths known
  issue with the two-step fix
- New optional plugins declared with `{'load': 'opt'}`: copilot.vim and
  codeium.vim (installed under `pack/plugins/opt/`, loaded on demand)
- vim-go pinned to v1.29

### Changed

- Sidebar width 40 -> 50 (`g:plugin_manager_sidebar_width` in
  `plugin_pluginmanager.vim`)
- `~/.vim/vimrc`: syntax first in the essentials block; quickstart snippet
  in the README kept byte-identical to the live vimrc

### Removed

- YouCompleteMe and neoinclude (YCM completion stack): no build step, no
  nested submodule dance; the LSP route covers the devops servers YCM
  never had

### Fixed

- `plugin_gutentags.vim`: `g:gutentags_exclude` was renamed
  `g:gutentags_ctags_exclude` upstream (startup warning)

### Documentation

- README + doc: node runtime section for coc (needs node >= 20; mise users
  pin a managed node via `g:coc_node_path`, the system default stays free)
- README known issue: YCM nested submodules are missing for BOTH install
  paths (declarative vimrc with or without the `exec` hook, and
  `:PluginManager add`): explicit two-step fix documented with examples,
  now marked historical (YCM era)
- Em dashes replaced with plain punctuation across README, CHANGELOG and
  doc (house style: no U+2014)

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
