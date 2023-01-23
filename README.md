# Dotfiles and settings
A collection of dotfiles, settings, and configurations.

* aliases
* bash
* emacs
* gitconfig
* tmux
* vim

## Setup:
1. Go to home dir: `cd ~`
1. Clone repo: `git clone https://github.com/williamgrimes/.dotfiles.git`
3. Make script executable using `chmod +x ~/.dotfiles/symlink_setup.sh`
4. Run script to create symbolic links:
 - `bash ~/.dotfiles/symlink_setup.sh --local`, or
 - `bash ~/.dotfiles/symlink_setup.sh --remote`
