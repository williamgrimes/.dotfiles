# Dotfiles and settings
A collection of dotfiles, settings, and configurations.

* aliases
* bash
* gitconfig
* tmux
* vim

## Setup:
1. Go to home dir: `cd ~`
1. Clone repo: `git clone https://github.com/williamgrimes/.dotfiles.git`
3. Make script executable using `chmod +x ~/.dotfiles/symlink_setup.sh`
4. Run script to create symbolic links `bash ~/.dotfiles/symlink_setup.sh`

## /bin/bash
In a bash environment these are some handy additions to the `.bashrc`:

```

alias c='clear'
alias r='reset'
alias q='exit'

alias ..="cd .."
alias ...='cd ../..'
alias ....='cd ../../..'
alias lll='ls -lh'
alias lll='ls -lha'
alias rm='rm -I'

alias install='sudo apt install'
alias update='sudo apt update'
alias upgrade='sudo apt upgrade'

# bash colours
grey='\[\033[1;30m\]'
red='\[\033[0;31m\]'
RED='\[\033[1;31m\]'
green='\[\033[0;32m\]'
GREEN='\[\033[1;32m\]'
yellow='\[\033[0;33m\]'
YELLOW='\[\033[1;33m\]'
purple='\[\033[0;35m\]'
PURPLE='\[\033[1;35m\]'
white='\[\033[0;37m\]'
WHITE='\[\033[1;37m\]'
blue='\[\033[0;34m\]'
BLUE='\[\033[1;34m\]'
cyan='\[\033[0;36m\]'
CYAN='\[\033[1;36m\]'
NC='\[\033[0m\]'

PS1="$yellow[$CYAN\t$yellow][$red\u$yellow][$blue\H$yellow][$GREEN\w$grey$yellow]$NC$(git branch 2>/dev/null | grep '^*' | colrm 1 2)$ "

export HISTTIMEFORMAT="%h %d %H:%M:%S "
export HISTSIZE=10000
export HISTFILESIZE=10000
shopt -s histappend
export HISTCONTROL=ignorespace:erasedups
export HISTIGNORE="ls:ll:lll:ps:history:z"

alias ll='ls -lh'
alias lll='ls -la'

alias running_services='systemctl list-units  --type=service  --state=running'

log_tail() {
    local n_lines="${2:-10}"
    sudo journalctl --lines="$n_lines" -f -u "$1" -o cat
}
```
