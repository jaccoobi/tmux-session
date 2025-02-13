#!/usr/bin/bash

echo "Create new project or open an existing one?"
read -p ": " option

if [ $option == "c" ]; then
  echo "TEST: creating new project"
elif [ $option == "o" ]; then
  project_dir=`cat .projects | fzf`
  echo $project_dir
else
  echo "Not a valid command."
fi

