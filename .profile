export PATH=$HOME/.local/bin:$PATH

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export LESS='-R --use-color -Dd+r$Du+b'
export LESSHISTFILE="-"
export MANPAGER="less -R --use-color -Dd+r -Du+b"
# export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history/.zsh_history"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export GIT_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/.gitconfig"
export FZF_DEFAULT_COMMAND="fd -t f --hidden --exclude .git"
export FZF_DEFAULT_OPTS="--layout=reverse --height 40% --border"
