#!/bin/zsh

# Capture the command to run from arguments
COMMAND="$@"

# Get the current directory
CURRENT_DIR=$(pwd)

# Get the session name based on the current directory or fallback to default
SESSION_NAME=$(tmux display-message -p '#S' 2>/dev/null || echo "${PWD##*/}")

# Check if the tmux session exists
tmux has-session -t "$SESSION_NAME" 2>/dev/null
SESSION_EXISTS=$?

if [ $SESSION_EXISTS != 0 ]; then
  # Session does not exist, create a new session
  if [ -z "$COMMAND" ]; then
    tmux new-session -ADs "$SESSION_NAME" -c "$CURRENT_DIR"
  else
    tmux new-session -ADs "$SESSION_NAME" -c "$CURRENT_DIR" \; send-keys "$COMMAND" C-m
  fi
else
  # Session exists, create a new window and run the command if provided
  if [ -z "$COMMAND" ]; then
    tmux attach-session -t "$SESSION_NAME"
  else
    tmux new-window -t "$SESSION_NAME" -c "$CURRENT_DIR" \; send-keys "$COMMAND" C-m
  fi
fi
