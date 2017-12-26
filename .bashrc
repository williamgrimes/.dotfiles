# ~/.bashrc

###############################
# SOURCE ALIASES
###############################
source ~/.aliasrc

###############################
# PYTHON STARTUP WITH READLINE
###############################
export PYTHONSTARTUP=/home/williamgrimes/.pythonstartup

###############################
# PATH SETTINGS
###############################
export PATH="/home/williamgrimes/anaconda3/bin:$PATH"
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

###############################
# POWERLINE
###############################
# ~/.local/lib/python3.5/site-packages/powerline/config_files/themes/shell/default.json  # remove left user
export TERM="screen-256color"
if [ -f ~/.local/lib/python3.5/site-packages/powerline/bindings/bash/powerline.sh ]; then
source ~/.local/lib/python3.5/site-packages/powerline/bindings/bash/powerline.sh
fi

###############################
# LANGUAGE OPTIONS
###############################
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

###############################
# CHECK WINDOWSIZE
###############################
shopt -s checkwinsize
