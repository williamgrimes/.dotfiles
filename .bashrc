source ~/.aliasrc

# added by Anaconda3 4.2.0 installer
export PATH="/home/williamgrimes/anaconda3/bin:$PATH"

export PYTHONSTARTUP=/home/williamgrimes/.pythonstartup

export TERM="screen-256color"
if [ -f /home/williamgrimes/.local/lib/python3.5/site-packages/powerline/bindings/bash/powerline.sh ]; then
source /home/williamgrimes/.local/lib/python3.5/site-packages/powerline/bindings/bash/powerline.sh
fi

shopt -s checkwinsize

# create logbook entry
function lb() {
    vim ~/logbook/$(date '+%Y-%m-%d').md
}

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
