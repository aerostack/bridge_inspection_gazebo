#!/bin/bash
SESSION=$USER

#pkill -SIGINT roslaunch
tmux kill-session -t main_launcher1
tmux kill-session -t main_launcher2
tmux kill-session -a
