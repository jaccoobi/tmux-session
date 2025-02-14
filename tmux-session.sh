#!/usr/bin/bash

read -p "Create new project or open an existing one? " option

if [ $option == "c" ]; then
  echo "TEST: creating new project" #TODO
elif [ $option == "o" ]; then
  project_dir=`find ~/Documents/dev -mindepth 1 -maxdepth 1 | fzf`

  project_name=`basename $project_dir | tr . _`
  tmux rename-session $project_name

  cd $project_dir
  tmux rename-window "nvim"

  tmux new-window
  tmux rename-window "run"
  
  tmux new-window
  tmux rename-window "git"
  bash lazygit

  # Go to first window
  tmux select-window -t:nvim
  yazi
elif [ $option == "q" ]; then
  exit 0 # TODO
else
  echo "Not a valid command."
fi

