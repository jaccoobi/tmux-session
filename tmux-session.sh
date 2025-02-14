#!/usr/bin/bash

open_session() {
  project_name=`basename $1 | tr . _`
  tmux rename-session $project_name

  tmux rename-window "nvim"

  tmux neww -n "run"
  
  tmux neww -n "git" # TODO: open lazygit

  # Go to first window
  tmux select-window -t:nvim
  yazi
}

read -p "Create new project or open an existing one? " option

if [ $option == "c" ]; then
  read -p "What is the name of the project? " name
  cd ~/Documents/dev/
  mkdir $name
  cd $name

  open_session ~/Documents/dev/$project_dir
elif [ $option == "o" ]; then
  project_dir=`find ~/Documents/dev -mindepth 1 -maxdepth 1 | fzf`
  cd $project_dir

  open_session $project_dir
elif [ $option == "q" ]; then
  exit 0 # TODO
else
  echo "Not a valid command."
fi

