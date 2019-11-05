#!/bin/sh
DISKNAME=`lsblk -nblo NAME,TYPE,SIZE | awk '(($2 == "disk") && ($3==500*2^30)) {print $1}'` # 500G disk
tmux new-session \; \
  send-keys 'htop' C-m \; \
  split-window -v \; \
  send-keys 'watch -n 60 "df -h"' C-m \; \
  split-window -h \; \
  send-keys 'watch -n 60 "who -a"' C-m \; \
  rename-window 'monitor' \; \
  new-window \; \
  rename-window '/mnt/data' \; \
  send-keys "eval sudo mount /dev/`lsblk -nblo NAME,TYPE,SIZE | awk '(($2 == "disk") && ($3==500*2^30)) {print $1}'` /mnt/data" C-m \; \
  send-keys 'cd /mnt/data' C-m \; \
  split-window -h \; \
  send-keys 'cd ~/Dropbox' C-m \; \
  send-keys 'dropbox status' C-m \; \
  new-window \; \
  rename-window 'notebooks' \; \
  send-keys 'cd ~/numerico/notebooks' C-m \; \
  send-keys 'source activate notebooks' C-m \; \
  send-keys 'ls -lh' C-m \; \
  new-window \;
