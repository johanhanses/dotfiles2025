export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace

setopt share_history
setopt append_history
setopt inc_append_history

# ZSH plugins
# First install with apt
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable word movement with Ctrl+Left/Right
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Enable beginning/end of line with Fn+Left/Right or Home/End
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

unset zle_bracketed_paste

# Environment Variables
export BAT_THEME="OneHalfDark"
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="firefox"
export XDG_CONFIG_HOME="$HOME/.config"
export REPOS="$HOME/Repos"
export GITUSER="johanhanses"
export GHREPOS="$HOME/Repos/github.com/johanhanses"
export DOTFILES="$GHREPOS/dotfiles2025"
export SCRIPTS="$DOTFILES/scripts"
export SECOND_BRAIN="$GHREPOS/zettelkasten"
export WORK_DIR="$REPOS/github.com/Digital-Tvilling"
export LKAB_DIR="$WORK_DIR/.lkab"
export ONPREM_CONFIG_DIR="$LKAB_DIR/on-prem/config"
export ONPREM_CERT_DIR="$LKAB_DIR/on-prem/cert"
export PATH="$XDG_CONFIG_HOME/scripts:$PATH:/home/johanhanses/.local/bin"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$PATH:/Users/johanhanses/Repos/github.com/johanhanses/dotfiles2025/scripts"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

# fzf default options
export FZF_DEFAULT_COMMAND="rg --files"
export FZF_DEFAULT_OPTS="--height 90% --border"

# fzf CTRL-T configuration
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# fzf ALT-C configuration
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# fzf tmux configuration
export FZF_TMUX=1
export FZF_TMUX_OPTS=""

# Aliases
alias repos="cd $REPOS"
alias ghrepos="cd $GHREPOS"
alias dot="cd $GHREPOS/dotfiles2025"
alias scripts="cd $DOTFILES/scripts"
alias rwdot="cd $REPOS/github.com/rwxrob/dot"
alias rob="cd $REPOS/github.com/rwxrob"
alias dt="cd $REPOS/github.com/Digital-Tvilling"
alias plan="cd $REPOS/github.com/Digital-Tvilling/DT-Frontend-planning"
alias rtm="cd $REPOS/github.com/Digital-Tvilling/dt-frontend-vite"
alias deploy="cd $REPOS/github.com/Digital-Tvilling/deployment-configuration"
alias backend="cd $REPOS/github.com/Digital-Tvilling/deployment-configuration/external/localhost"
alias dti="cd $REPOS/github.com/Digital-Tvilling/dti"
alias home="cd $REPOS/github.com/johanhanses/johanhanses.com/"
alias sb="cd $SECOND_BRAIN"
alias config="cd $XDG_CONFIG_HOME"

alias cat="bat"
alias fast="fast -u --single-line"
alias speed="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -"

alias htop="btm -b"
alias neofetch="fastfetch"
alias photos="npx --yes icloudpd --directory ~/icloud-photos --username johanhanses@gmail.com --watch-with-interval 3600"
alias nv="nvim"
alias c="clear"

alias n="npm"
alias nr="npm run"
alias ns="npm start"

alias ls="ls --color=auto"
alias ll="eza -l -a -a -g --group-directories-first --show-symlinks --icons=always"
alias l="eza -l -g --group-directories-first --show-symlinks --icons=always"
alias la="ls -lathr"
alias lg="lazygit"

alias tree="eza --tree"
alias e="exit"

alias gm="git checkout main && git pull"
alias gd="git diff"
alias gp="git push"
alias ga="git add ."
alias gs="git status"
alias gc="git checkout"
alias gcb="git checkout -b"
alias gcm="git commit -m"
alias wip="git commit -m \"wip\" --no-verify"

alias k="kubectl"

alias t="tmux"
alias tk="tmux kill-server"
alias tl="tmux ls"
alias ta="tmux a"


alias d="docker"
alias dc="docker compose"

alias szr="source ~/.zshrc"

# alias dark="gsettings set org.cinnamon.theme name 'Mint-Y-Dark'"
# alias light="gsettings set org.cinnamon.theme name 'Mint-Y'"

# alias dark="kitten themes --reload-in=all One Half Dark && gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' && export BAT_THEME='OneHalfDark'"
# alias light="kitten themes --reload-in=all One Half Light && gsettings set org.gnome.desktop.interface color-scheme 'prefer-light' && export BAT_THEME='OneHalfLight'"

alias dark="gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' && export BAT_THEME='OneHalfDark'"
alias light="gsettings set org.gnome.desktop.interface color-scheme 'prefer-light' && export BAT_THEME='OneHalfLight'"


# Initialize Starship prompt
eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
