source ~/.aliasrc

# added by Anaconda3 4.2.0 installer
export PATH="/home/williamgrimes/anaconda3/bin:$PATH"

export PYTHONSTARTUP=/home/williamgrimes/.pythonstartup

export TERM="screen-256color"
if [ -f /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh ]; then
source /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh
fi

shopt -s checkwinsize

function lb() {
    vim ~/logbook/$(date '+%Y-%m-%d').md
}

