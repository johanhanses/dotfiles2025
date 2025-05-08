# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace

# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

export PATH=$PATH:/home/johanhanses/.local/bin
export PATH=$HOME/bin:/usr/local/bin:$PATH
export XDG_CONFIG_HOME="$HOME"/.config
export REPOS="$HOME/Repos"
export GITUSER="johanhanses"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
export SCRIPTS="$DOTFILES/scripts"
export SECOND_BRAIN=$GHREPOS/zettelkasten

export VISUAL=nvim
export EDITOR="$VISUAL"

export CLICOLOR=1
# export TERM=xterm-256color
# export COLORTERM=truecolor
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export WORK_DIR="$REPOS/github.com/Digital-Tvilling"
export LKAB_DIR=${WORK_DIR}/.lkab
export ONPREM_CONFIG_DIR=${LKAB_DIR:?}/on-prem/config
export ONPREM_CERT_DIR=${LKAB_DIR:?}/on-prem/cert
export PATH="$XDG_CONFIG_HOME/scripts:$PATH"

alias repos="cd $REPOS"
alias ghrepos="cd $GHREPOS"
alias dot="cd $GHREPOS/dotfiles"
alias scripts="cd $DOTFILES/scripts"
alias rwdot="cd $REPOS/github.com/rwxrob/dot"
alias rob="cd $REPOS/github.com/rwxrob"
alias dt="cd $REPOS/github.com/Digital-Tvilling"
alias plan="cd $REPOS/github.com/Digital-Tvilling/DT-Frontend-planning"
alias rtm="cd $REPOS/github.com/Digital-Tvilling/dt-frontend-vite"
alias deploy="cd $REPOS/github.com/Digital-Tvilling/deployment-configuration"
alias backend="cd $REPOS/github.com/Digital-Tvilling/deployment-configuration/external/localhost"
alias dti="cd $REPOS/github.com/Digital-Tvilling/dti"
# alias icloud="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs"
alias sb="cd $SECOND_BRAIN"
alias in="cd $SECOND_BRAIN/0\ Inbox"
alias config="cd $XDG_CONFIG_HOME"
alias windows="cd /mnt/c/Users/johanhanses"

alias szr="source ~/.zshrc"
# alias cat="bat"
alias fast="fast -u --single-line"
alias nv=nvim
alias ..="cd .."
alias c="clear"
alias '?'=duck
alias '??'=gpt
alias '???'=google

alias n="npm"
alias nr="npm run"
alias ns="npm start"

alias ls='ls --color=auto'
alias ll='ls -la'
alias l='ls -l'
alias la='ls -lathr'
alias e='exit'

alias gm="git checkout main && git pull"
alias gp='git push'
alias ga="git add ."
alias gs='git status'
alias gc="git checkout"
alias gcb="git checkout -b"
alias gcm="git cz"
alias wip="git commit -m 'wip' --no-verify"

alias lg='lazygit'

alias k='kubectl'

alias t='tmux'
alias tk='tmux kill-server'
alias tl='tmux ls'
alias ta='tmux a'

# Docker
alias d="docker"
alias dc="docker compose"

# Find and set branch name var if in git repository.
# function git_branch_name()
# {
#   branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
#   if [[ $branch == "" ]];
#   then
#     :
#   else
#     echo ''%F{yellow}$branch%f''
#   fi
# }

# Enable substitution in the prompt.
# setopt prompt_subst

# Set the prompt
# export PROMPT='%B%F{cyan}%0~%f $(git_branch_name)$ '

eval "$(starship init zsh)"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/johanhanses/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
