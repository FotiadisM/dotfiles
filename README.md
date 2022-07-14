# Dotfiles

<p align="center">
   <img src="https://raw.githubusercontent.com/jglovier/dotfiles-logo/main/dotfiles-logo.svg" alt="dotfiles logo"/>
</p>

My dotfiles  
Feel free to use anything you want.  
I highly recommend using [GNU Stow](https://www.gnu.org/software/stow/) for managing your dotfiles. Using a git bare repository gets very messy.

## Installation

```bash
git clone https://github.com/FotiadisM/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# using stow
stow <app config>
```

> You can specify a different location with stow -d \<stow dir\> -t $HOME

## Uninstall

```bash
stow -D <app config>
```
