# ~/.bashrc

###############################
# SOURCE ALIASES
###############################
source ~/.aliasrc

###############################
# ANACONDA ON PATH
###############################
export PATH="/home/williamgrimes/anaconda3/bin:$PATH"

###############################
# PYTHON STARTUP WITH READLINE
###############################
export PYTHONSTARTUP=/home/williamgrimes/.pythonstartup

###############################
# TMUX POWERLINE
###############################
# ~/.local/lib/python3.5/site-packages/powerline/config_files/themes/tmux/default.json  # edit right segments
# ~/.local/lib/python3.5/site-packages/powerline/config_files/themes/shell/default.json  # remove left user
export TERM="screen-256color"
if [ -f /home/williamgrimes/.local/lib/python3.5/site-packages/powerline/bindings/bash/powerline.sh ]; then
source /home/williamgrimes/.local/lib/python3.5/site-packages/powerline/bindings/bash/powerline.sh
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
