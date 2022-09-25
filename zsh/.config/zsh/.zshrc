pfetch

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="${XDG_DATA_HOME:-$HOME/.local/share}/oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=${XDG_DATA_HOME:-$HOME/.local/share}/oh-my-zsh/custom

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	# custom
	zsh-syntax-highlighting
	zsh-autosuggestions
	lxd-completion-zsh

	# included
	git
	docker
	docker-compose
	golang
	terraform
	kubectl
	minikube
	heroku
	helm
	npm
	yarn
	pip
	fzf
	gh
	rust
	colored-man-pages
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Enable vi mode
bindkey -v
# Enter Normal mode faster
KEYTIMEOUT=1

# commands that start with space are not
# writtern in history
setopt HIST_IGNORE_SPACE

# Ctrl-x-e to edit command in nvim
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^E" edit-command-line

# source lf icons
[ -f "$HOME/.config/lf/icons.sh" ] && source "$HOME/.config/lf/icons.sh"
# source lfcd
[ -f "$HOME/.config/lf/lfcd.sh" ] && source $HOME/.config/lf/lfcd.sh

# Preferred editor for remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias c='clear'
alias ls='ls -v --color=auto --group-directories-first'
alias la='ls -lAhv --color=auto --group-directories-first'
alias l='la $(fd -H -E .git -E node_modules | fzf)'
alias ip='ip -color'
alias open='xdg-open'
alias nvimrc='(cd $HOME/.config/nvim && nvim)' # avoid creating buffer for dir
alias zshrc='nvim $HOME/.config/zsh/.zshrc'
alias d='cd $(fd -t d -H -E .git -E node_modules | fzf)'
alias dn='nvim $(fd -t d -E .git -E node_modules | fzf)'
alias dnh='nvim $(fd -t d -H -E .git -E node_modules | fzf)'
alias dt='tmux-sessioner.sh'
alias f='fzf-nvim.sh'
alias t='tmux'
alias tn='tmux new -A -s default'
alias nv='nvim'

alias kn='kubectl config set-context --current --namespace'
alias kuc='kubectl config use-context'

# don't generate the history file at $HOME
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'

[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

autoload -U compinit && compinit
