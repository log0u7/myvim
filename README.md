# MyVim

```
  __
 (`/\
 `=\/\ __...--~~~~~-._   _.-~~~~~--...__
  `=\/\    My Vim     \ /               \\
   `=\/                V    Tiny IDE     \\
   //_\___--~~~~~~-._  |  _.-~~~~~~--...__\\
  //  ) (..----~~~~._\ | /_.~~~~----.....__\\
 ===( INK )==========\\|//====================
_____\___/___________`---`______________________
```

MyVim is a lightweight DevOps IDE for Vim 8.2+. It is a **personal
configuration plugin**: it ships the per-plugin settings and mappings in
`plugin/*.vim`. Plugins themselves live as Git submodules of your `~/.vim`
repository, managed by
[vim-plugin-manager](https://github.com/log0u7/vim-plugin-manager) through
Vim 8's native package system.

> The full live example is a `~/.vim` git repository: base settings in
> `~/.vim/vimrc` (symlinked to `~/.vimrc`), one plugin per submodule under
> `pack/plugins/start/`, and MyVim declared last so its settings load after
> every plugin. In-editor documentation: `:help myvim`.

## Layout and conventions

```
plugin/
  vim_*.vim       pure Vim config: settings, mappings, colorscheme
  plugin_*.vim    per-plugin config (g: variables, autocmds), one per plugin
ftplugin/         filetype-specific settings (e.g. yaml.vim)
doc/myvim.txt     :help myvim
```

| File | Role |
|---|---|
| `plugin/vim_settings.vim` | General options (undo, swap, diff, `W`/`Q` commands) |
| `plugin/vim_mappings.vim` | Every global key mapping (single audit point) |
| `plugin/vim_colorscheme.vim` | Colorscheme activation mechanism |
| `plugin/plugin_ale.vim` | ALE linters for devops filetypes |
| `plugin/plugin_gutentags.vim` | ctags exclusions |
| `plugin/plugin_<name>.vim` | One file per configured plugin |
| `ftplugin/yaml.vim` | Filetype settings (2-space indent) |

## Quickstart

### 1. Backup your current setup

```bash
cp -a ~/.vim ~/.vim~
cp ~/.vimrc ~/.vimrc~
```

### 2. Prepare the new ~/.vim

```bash
cd ~/.vim
git init
mkdir -p swapdir undodir
cat > .gitignore <<'EOF'
undodir/*
swapdir/*
logs/
*.swp
*.swo
.*.swp
doc/tags
**/doc/tags
.netrwhist
plugin/*-secrets.vim
EOF
```

### 3. Install vim-plugin-manager

```bash
git submodule add https://github.com/log0u7/vim-plugin-manager.git \
  pack/plugins/start/vim-plugin-manager
vim -c "helptags ~/.vim/pack/plugins/start/vim-plugin-manager/doc" -c q
```

### 4. Write ~/.vim/vimrc

Only what must run before plugins load stays in the vimrc; the general
settings and mappings come from MyVim. On startup, every missing plugin is
installed automatically as a submodule.

```vim
" essentials: must run before plugin/*.vim load
syn on
filetype plugin indent on
set nocompatible
set encoding=UTF-8
set background=dark
" Mapleader must be defined before plugins load ! (default '\', uncomment to change)
"let mapleader = "\"

" Plugins managed by vim-plugin-manager (Git submodules + native packages)
packadd vim-plugin-manager
PluginBegin
  " --- basics / UI ---
  Plugin 'tpope/vim-sensible'
  Plugin 'tpope/vim-sleuth'
  Plugin 'chrisbra/matchit'
  Plugin 'vim-airline/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'
  Plugin 'bling/vim-bufferline'
  Plugin 'edkolev/tmuxline.vim'
  Plugin 'wincent/terminus'
  Plugin 'ryanoasis/vim-devicons'
  Plugin 'Yggdroot/indentLine'
  Plugin 'jiangmiao/auto-pairs'
  Plugin 'ludovicchabant/vim-gutentags'
  Plugin 'christoomey/vim-tmux-navigator'
  " --- navigation / IDE panels ---
  Plugin 'preservim/nerdtree'
  Plugin 'Xuyuanp/nerdtree-git-plugin'
  Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plugin 'preservim/tagbar'
  Plugin 'ctrlpvim/ctrlp.vim'
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
  Plugin 'ekalinin/Dockerfile.vim'
  Plugin 'saltstack/salt-vim'
  Plugin 'hashivim/vim-hashicorp-tools'
  Plugin 'jvirtanen/vim-hcl'
  Plugin 'Glench/Vim-Jinja2-Syntax'
  Plugin 'jmcantrell/vim-virtualenv'
  Plugin 'fatih/vim-go', {'tag': 'v1.28'}
  " --- docs / notes ---
  Plugin 'iamcco/markdown-preview.nvim'
  Plugin 'vimwiki/vimwiki'
  " --- personal configuration plugin (loads last) ---
  Plugin 'log0u7/myvim'
PluginEnd
```

### 5. Symlink the vimrc

```bash
ln -sf ~/.vim/vimrc ~/.vimrc
```

### 6. First launch

```bash
vim
```

vim-plugin-manager reads the `PluginBegin` block and installs every missing
plugin as a submodule, then commits the changes. Commit and push `~/.vim` to
back the setup up (`:PluginManager backup` once a remote exists).

## Post-install steps

| Plugin | Action |
|---|---|
| coc.nvim | Nothing to build: declared extensions (`g:coc_global_extensions` in `plugin_coc.vim`) auto-install at first start. Generic LSP servers (terraform-ls) are configured in the same file and need their binary in PATH |
| markdown-preview.nvim | Run `:call mkdp#util#install()` once (downloads prebuilt assets, no npm needed) |
| fzf | Nothing to do: `{'dir': 'fzf', 'exec': './install --all'}` installs the binary |

## Enable a colorscheme

No colorscheme is forced by default (the terminal palette applies). To
activate one:

1. Uncomment its `Plugin` line in `~/.vim/vimrc`
   (solarized / gruvbox8 / tokyonight / onedark).
2. Uncomment the matching call in `plugin/vim_colorscheme.vim`.
3. Restart vim.

## Secrets

Never commit API tokens. Keep them in a gitignored file:

```bash
# in ~/.vim/.gitignore
plugin/*-secrets.vim
```

```vim
" in ~/.vim/plugin/fugitive-secrets.vim (unversioned)
let g:gitlab_api_keys = {'gitlab.com': 'YOURTOKEN'}
```

## Key mappings

| Key | Action |
|---|---|
| `<F2>` | NERDTree toggle |
| `<F3>` | Plugin Manager sidebar |
| `<F4>` | Minimap toggle |
| `<F7>` | Undotree toggle |
| `<F8>` | Markdown Preview (markdown buffers) |
| `<C-p>` | CtrlP files |
| `<leader>p` / `<leader>b` / `<leader>g` | fzf Files / Buffers / Git files |
| `gd` / `K` / `<leader>d` / ... | coc.nvim LSP actions (see the coc.nvim section) |

All mappings live in `plugin/vim_mappings.vim` (and
`plugin/plugin_coc.vim` for the LSP ones) - edit there, not in the
`plugin_*.vim` files.

## Why a minimal vimrc

Vim sources `plugin/*.vim` files after the vimrc, in runtimepath order
(alphabetical). Anything a plugin needs at load time must therefore exist
before that phase: `mapleader` (or leader-based mappings bind the wrong
key), `encoding`, and `filetype plugin indent on` stay in the vimrc.
Everything else (options, mappings, per-plugin settings) lives in the
MyVim plugin, so the vimrc stays declarative: settings evolve in the plugin
repo, plugin versions are pinned as submodules, and `~/.vim` remains a
thin, reproducible list.

## coc.nvim: LSP engine (YouCompleteMe retired)

After more than a decade of loyal service, YouCompleteMe was retired on
2026-09-16 and replaced by [coc.nvim](https://github.com/neoclide/coc.nvim).
Thank you, YCM: a decade of inline completion and semantic highlighting
carried this IDE through its Vim 8 years.

Why the switch, for a DevOps/SRE stack:

| | YCM | coc.nvim |
|---|---|---|
| Language support | fixed ycmd completers (clangd, go, jedi...) | **any LSP server** |
| DevOps servers | none | ansible-language-server, yaml-ls, bash-ls, dockerfile-ls, terraform-ls... |
| Build step | `install.py --all` + nested submodules | none (extensions auto-install) |
| Project health | maintenance mode | active ecosystem |

Configuration lives in `plugin/plugin_coc.vim`: the extension list
(`g:coc_global_extensions`: yaml, json, git, sh, docker, toml, ansible,
vimlsp), the generic `terraform-ls` server (needs `terraform-ls` in PATH),
and the mappings below. ALE keeps the devops linters with LSP disabled
(`ale_disable_lsp=1`); set `let g:ale_enabled = 0` if you prefer coc-only
diagnostics.

### Node runtime (coc needs node >= 20)

coc's bundle uses the RegExp `v` flag (ES2024): any node **>= 20** works,
older defaults (a distro node 18 for instance) crash the client at startup
with `SyntaxError: Invalid flags supplied to RegExp constructor 'v'`.

- **mise users**: install once (`mise install node@22`) and pin coc to it
  without touching the system default — `plugin_coc.vim` already does:

  ```vim
  let g:coc_node_path = expand('~/.local/share/mise/installs/node/22.23.2/bin/node')
  ```

  Bump the path after `mise install node@<newer>`. The rest of the system
  keeps its own node (18 here).

- **Everyone else**: put a node >= 20 binary in `PATH`, nothing to
  configure (`g:coc_node_path` unset means coc uses `node` from `PATH`).

The smoke suite (`make smoke`) checks that the pinned binary is present.

coc mappings (added to the mappings table):

| Key | Action |
|---|---|
| `gd` / `gr` / `gi` | definition / references / implementation |
| `K` | hover documentation |
| `[g` / `]g` | previous / next diagnostic |
| `<leader>rn` | rename symbol |
| `<leader>ca` | code action |
| `<leader>d` | diagnostics list |
| `<leader>o` | outline |

## Known issues (historical: YCM era)

- **YouCompleteMe nested submodules (both install paths)**: the manager
  clones plugins non-recursively, so YCM's nested submodule
  (`third_party/ycmd`) is missing right after installation. Both install
  paths are affected:

  - declarative, in the vimrc (with or without the `exec` hook):

    ```vim
    Plugin 'ycm-core/YouCompleteMe', {'exec': './install.py --all'}
    ```

    with the `exec` hook, `install.py` runs while `third_party/ycmd` is
    still absent, so the build fails (see the manager log,
    `COMMAND_FAILED`); without the hook, nothing runs at all;

  - imperative, from the sidebar or the command line:

    ```vim
    :PluginManager add ycm-core/YouCompleteMe
    ```

    same result: no nested submodule, no build.

  Fix in both cases: initialize the nested submodule first, then build:

  ```bash
  git -C pack/plugins/start/YouCompleteMe submodule update --init --recursive
  python3 pack/plugins/start/YouCompleteMe/install.py --all
  ```

  Without the recursive init, `install.py` aborts with missing
  `third_party/ycmd`.

## Legacy

The old layout (whole config + 41 plugins as nested submodules in this repo)
is preserved at tag [`legacy-full-config`](https://github.com/log0u7/myvim/tree/legacy-full-config).
