#!/usr/bin/bash

java_project() {
  read -p "Enter the groupId (org.apache.maven): " group_id
  read -p "Enter the artifactID (maven-clean-plugin): " artifact_id

  # maven
  mvn archetype:generate -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-quickstart -DgroupId="$group_id" -DartifactId="$artifact_id"

  # rename dir to language standard
  mv "./$artifact_id/" "./java-$artifact_id/"
  cd "java-$artifact_id"

  # git
  git init

  open_session "~/Documents/dev/java-$artifact_id"
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
  languages="java"
  project_language=`echo $languages | fzf --prompt "Language > "`

  cd ~/Documents/dev/

  if [ $project_language == "java" ]; then
    java_project
  else
    read -p "What is the name of the project? " name
    mkdir $name
    cd $name
    open_session ~/Documents/dev/$name
  fi

elif [ $option == "o" ]; then
  project_dir=`find ~/Documents/dev -mindepth 1 -maxdepth 1 | fzf`
  cd $project_dir

  open_session $project_dir
elif [ $option == "q" ]; then
  exit 0 # TODO
else
  echo "Not a valid command."
fi

