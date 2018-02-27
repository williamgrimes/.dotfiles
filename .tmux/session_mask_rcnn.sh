#!/bin/sh 

SESSION_NAME="msk_rcnn"
tmux new-session -s $SESSION_NAME -d htop
tmux split-window -v watch -n 1 nvidia-smi
tmux select-pane -t 1
tmux rename-window "monitor"
tmux attach-session -t $SESSION_NAME
