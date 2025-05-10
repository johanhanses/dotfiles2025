#!/usr/bin/env sh

# Originally Stolen from Jess Archer https://github.com/jessarcher/dotfiles/blob/master/install, then modded by me

DOTFILES="$(pwd)"
DOTFILES_PRIVATE="$HOME/Repos/github.com/johanhanses/dotfiles-private"

# Zsh
ln -sf $DOTFILES/zshrc/linux/.zshrc $HOME/.zshrc
# ln -sf $DOTFILES/zshrc/wsl/.zshrc $HOME/.zshrc

# Neovim
rm -rf $HOME/.config/nvim
ln -s $DOTFILES/nvim/ $HOME/.config/nvim

# Kitty
rm -rf $HOME/.config/kitty
ln -sf $DOTFILES/kitty/ $HOME/.config/kitty

# Tmux
rm -rf $HOME/.config/tmux
ln -sf $DOTFILES/tmux/ $HOME/.config/tmux

# Git
ln -sf $DOTFILES/.gitconfig $HOME/.gitconfig
ln -sf $DOTFILES/.gitignore_global $HOME/.gitignore_global

# Scripts
# rm -rf $HOME/.config/scripts
# ln -sf $DOTFILES/scripts/ $HOME/.config/scripts

# .kube
rm -rf $HOME/.kube
ln -sf $DOTFILES_PRIVATE/.kube/ $HOME/.kube

# btop
rm -rf $HOME/.config/btop
ln -sf $DOTFILES/btop/ $HOME/.config/btop

# newsboat
rm -rf $HOME/.config/newsboat
ln -sf $DOTFILES/newsboat/ $HOME/.config/newsboat

# ghostty
rm -rf $HOME/.config/ghostty
ln -sf $DOTFILES/ghostty/ $HOME/.config/ghostty






