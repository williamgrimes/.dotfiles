#!/bin/bash
mkdir -p ~/.config/fish/
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/config.fish ~/.config/fish/config.fish
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/personal.el ~/.emacs.d/personal/personal.el
