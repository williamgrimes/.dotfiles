#!/bin/sh 
SESSION_NAME="gpu"
tmux new-session -s $SESSION_NAME -d htop
tmux split-window -v glances
tmux select-pane -t 1
tmux rename-window "monitor"
tmux attach-session -t $SESSION_NAME
