export PATH=$HOME/.local/bin:$PATH

export EDITOR='nvim'

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export HISTFILE="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zsh_history"

export LESS='-R --use-color -Dd+r$Du+b'
export LESSHISTFILE="-"
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"

export FZF_DEFAULT_COMMAND="fd -t f -H -E .git -E node_modules"
export FZF_DEFAULT_OPTS="--layout=reverse --height 40% --border"

export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share/}/rustup"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share/}/cargo"
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/npm"
export NPM_CONFIG_PREFIX="${XDG_DATA_HOME:-$HOME/.local/share/}/npm"
