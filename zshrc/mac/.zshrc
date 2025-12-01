export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace

setopt share_history
setopt append_history
setopt inc_append_history

# Enable completions
autoload -Uz compinit && compinit

# # First install with brew (apple sil)
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

unset zle_bracketed_paste

# Environment Variables
export BAT_THEME="Visual Studio Dark+"
export EDITOR="nvim"
export VISUAL="nvim"
# export BROWSER="firefox"

# Updated to use Google Chrome instead of Firefox
# export BROWSER="google-chrome"

# Alternative options for macOS:
export BROWSER="open -a 'Google Chrome'"
export BROWSER="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
# export BROWSER="open -a 'Safari'"

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
export PATH="$PATH:/Users/johanhanses/Repos/github.com/johanhanses/dotfiles2025/scripts"
export PATH="$PATH:/Users/johanhanses/Repos/github.com/johanhanses/zettelkasten"
# export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/node@22/lib"
export CPPFLAGS="-I/opt/homebrew/opt/node@22/include"

export AWS_PROFILE=saml

KUBECONFIG=~/.kube/config

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

plugins=(git)

source $ZSH/oh-my-zsh.sh

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

# alias htop="btm -b"
# alias neofetch="fastfetch"
alias photos="npx --yes icloudpd --directory ~/icloud-photos --username johanhanses@gmail.com --watch-with-interval 3600"
alias nv="nvim"
alias c="clear"
alias cl="claude"
alias ca="cursor-agent"

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

alias z="zellij"

alias d="docker"
alias dc="docker compose"

alias szr="source ~/.zshrc"

# Lägg till i ~/.zshrc
# if [[ "$(uname -s)" == "Darwin" ]]; then
#   # Använd osascript för att få korrekt dark mode status (funkar med Auto mode)
#   is_dark=$(osascript -e 'tell application "System Events" to tell appearance preferences to get dark mode')
#
#   if [[ "$is_dark" == "true" ]]; then
#     osascript -e 'tell application "Terminal" to set current settings of tabs of windows to settings set "ayu-dark"' &> /dev/null
#   else
#     osascript -e 'tell application "Terminal" to set current settings of tabs of windows to settings set "ayu-light"' &> /dev/null
#   fi
# fi
