#!/bin/env bash

set -eu

ZSH=$HOME/.local/share/oh-my-zsh
ZSH_CUSTOM=$ZSH/custom
git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git $ZSH
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

NEOVIM_SRC=$HOME/src/neovim
mkdir -p $NEOVIM_SRC
git clone https://github.com/FotiadisM/other.nvim.git $NEOVIM_SRC/other.nvim
git clone https://github.com/FotiadisM/nvim-material-icon.git $NEOVIM_SRC/nvim-material-icon

rustup default stable
rustup toolchain install
