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
This project aim to provide a simple way for managing vims plugins using git submodules.

See : [Using git submodules](./using-git-submodules.md)
## Installation

- Clone the repository :
    ```bash
    git clone --recursive https://github.com/log0u7/myvim.git
    ```
    _Note : You can ommit `--recursive` if you dont want to clone plugins i use.`_

- Symlink `.vim` and `.vimrc`:
    ```bash
    ln -sf myvim ~/.vim
    ln -sf myvim/vimrc ~/.vimrc
    ```
- Change remote origin for your git repository :
    ```bash
    cd ~/.vim
    git remote set-url origin your_git_repository_url
    ```

## Configure
If you want to use [pathogen](https://github.com/tpope/vim-pathogen) instead of Vim 8's packages,
you will have to change runtime path for `pack/plugins/start/` : 
```vimscript
execute pathogen#infect('pack/plugins/start/{}')
```

## Use plugins script
