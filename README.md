# Dotfiles and settings
A collection of dotfiles, settings, and configurations for local machine and when setting up new remote servers. 

* aliases
* bash
* gitconfig
* python
* tmux
* vim
* vimium

## Setup:
### Local
1. clone repo: `git clone https://github.com/williamgrimes/dotfiles.git`
2. move directory to .dotfiles `mv dotfiles/ .dotfiles/`
3. make script executable using `chmod +x ~/.dotfiles/symlink_setup_local.sh`
4. run script to create symbolic links `bash ~/.dotfiles/symlink_setup_local.sh`

### Remote
1. clone repo: `git clone https://github.com/williamgrimes/dotfiles.git`
2. move directory to .dotfiles `mv dotfiles/ .dotfiles/`
3. make script executable using `chmod +x ~/.dotfiles/symlink_setup_remote.sh`
4. run script to create symbolic links `bash ~/.dotfiles/symlink_setup_remote.sh`
