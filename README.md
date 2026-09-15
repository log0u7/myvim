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
____\___/___________`---`______________________
```

MyVim is a lightweight DevOps IDE for Vim 8.2+. Since the 2026 restructure it is
a **personal configuration plugin**: it ships only the per-plugin settings and
mappings in `plugin/*.vim`. Plugins themselves are managed by
[vim-plugin-manager](https://github.com/log0u7/vim-plugin-manager) as Git
submodules of your `~/.vim` directory.

> The full live example lives in a `~/.vim` git repository: base settings in
> `~/.vim/vimrc` (symlinked to `~/.vimrc`), one plugin per submodule under
> `pack/plugins/start/`, and MyVim declared last so its settings load after
> every plugin.

## Install

1. Make `~/.vim` a Git repository and add the plugin manager:

```bash
cd ~/.vim && git init
git submodule add https://github.com/log0u7/vim-plugin-manager.git \
  pack/plugins/start/vim-plugin-manager
```

2. Declare your plugins declaratively in `~/.vim/vimrc`, MyVim last:

```vim
packadd vim-plugin-manager
PluginBegin
  Plugin 'tpope/vim-fugitive'
  " ... every plugin you want ...
  Plugin 'log0u7/myvim'
PluginEnd
```

On startup, vim-plugin-manager installs every missing declaration as a
submodule. Commit and push `~/.vim` to back the setup up
(`:PluginManager backup`).

3. Symlink the vimrc:

```bash
ln -sf ~/.vim/vimrc ~/.vimrc
```

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

## Post-install steps

| Plugin | Action |
|---|---|
| YouCompleteMe | `{'exec': './install.py --all'}` builds it automatically; requires cmake, python3-dev, node. Manual: `python3 pack/plugins/start/YouCompleteMe/install.py --all` |
| markdown-preview.nvim | Run `:call mkdp#util#install()` once (downloads prebuilt assets, no npm) |
| fzf | Declared with `{'dir': 'fzf', 'exec': './install --all'}` (installs the fzf binary) |

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
