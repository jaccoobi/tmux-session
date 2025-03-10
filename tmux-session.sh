#!/usr/bin/bash

java_project() {
  # maven
  mvn archetype:generate -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.5

  # git
  git init
}

open_session() {
  project_name=`basename $1 | tr . _`
  tmux rename-session $project_name

  tmux rename-window "nvim"

  tmux neww -n "run"

  # Go to first window
  tmux select-window -t:nvim
  yazi
}

read -p "Create new project or open an existing one? " option

if [ $option == "c" ]; then
  read -p "What is the name of the project? " name
  languages="java"
  project_language=`echo $languages | fzf`

  cd ~/Documents/dev/
  mkdir $name
  cd $name

  if [ $project_language == "java" ]; then
    java_project
  fi

  open_session ~/Documents/dev/$name
elif [ $option == "o" ]; then
  project_dir=`find ~/Documents/dev -mindepth 1 -maxdepth 1 | fzf`
  cd $project_dir

  open_session $project_dir
elif [ $option == "q" ]; then
  exit 0 # TODO
else
  echo "Not a valid command."
fi

