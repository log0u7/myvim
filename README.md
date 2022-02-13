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
This project aim to provide a lightwheight DevOps IDE and a simple way for managing vims plugins using git submodules.

## Installation
- Backup you installation :
    ```bash
    cp .vim .vim~
    cp .vimrc .vimrc~ 
    ```

- Clone the repository :
    ```bash
    git clone --recursive https://github.com/log0u7/myvim.git .vim
    ```
    _Note : You can ommit `--recursive` if you dont want to clone plugins i use.`_

- Symlink `.vimrc`:
    ```bash
    ln -sf ~/.vim/vimrc ~/.vimrc
    ```
- Change remote origin for your git repository :
    ```bash
    cd ~/.vim
    git remote rename origin genesis
    git remote add origin your_repository_url
    ```
    _Note : you can have multiple url on the same remote as backup_
    ```
    git remote set-url origin --add --push second_repository_url
    git remote set-url origin --add --push third_repository_url
    ```

## Configure
If you want to use [pathogen](https://github.com/tpope/vim-pathogen) instead of Vim 8's packages,
you will have to change runtime path for `pack/plugins/start/` : 
```vimscript
execute pathogen#infect('pack/plugins/start/{}')
```

Some plugins require third party installation or [configuration](./vimrc), refers to plugins documentation like [YouCompleteMe](https://github.com/ycm-core/YouCompleteMe#installation).

## Use plugins script
`plugins` script is just an helper you can manage plugins manualy see [Using git submodules](./using-git-submodules.md) _(maybe not up to date)_.
