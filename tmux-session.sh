#!/usr/bin/bash

echo "Create new project or open an existing one?"
read -p ": " option

if [ $option == "c" ]; then
  echo "TEST: creating new project"
elif [ $option == "o" ]; then
  project_dir=`find ~/Documents/dev -maxdepth 1 | fzf`

  project_name=`basename $project_dir | tr . _`
  tmux rename-session $project_name

  cd $project_dir
  tmux rename-window "nvim"

  tmux new-window
  tmux rename-window "run"
  
  tmux new-window
  tmux rename-window "git"

  # Go to first window
  tmux select-window -t:nvim
  cd $project_dir
  yazi
elif [ $option == "q" ]; then
  exit 0
else
  echo "Not a valid command."
fi

