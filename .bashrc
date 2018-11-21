# ~/.bashrc

###############################
# SYNDAEMON DISABLE TOUCHPAD
###############################
if [ -n "$(start-stop-daemon --stop --name syndaemon)" ]; then
    exec /usr/bin/syndaemon -i .5 -K -R -d &
fi

###############################
# SOURCE ALIASES AND FUNCTIONS
###############################
source ~/.aliasrc

###############################
# PYTHON STARTUP WITH READLINE
###############################
export PYTHONSTARTUP=$HOME/.pythonstartup

###############################
# PYTHON PATH SETTINGS
###############################
export PATH="/opt/miniconda3/bin:$PATH"
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

###############################
# LOGBOOK FUNCTION
###############################
function lb() {
    file=~/logbook/$(date '+%Y-%m-%d').md
    if [ -e "$file" ]; then
        vim "$file"
    else 
        echo "# $(date '+%Y-%m-%d')" > "$file"
        vim "$file"
    fi 
}

###############################
# MARKDOWN VIEWER
###############################
function mdv () {
  pandoc $1 | lynx -stdin -vikeys
}
