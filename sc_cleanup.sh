#!/usr/bin/env bash

do_cleanup(){
  backuppath="$HOME/Documents/SC Stuff/SC_backup_$(date +%F)"
  controlslocation="/c/Program Files/Roberts Space Industries/StarCitizen/LIVE/USER"
  shaderslocation="$HOME/AppData/Local/Star Citizen/sc-alpha"

  echo "Starting SC cleanup"

  # move controls etc. to a backup location
  if [ ! -d "$backuppath" ]; then
    mkdir -p "$backuppath"
  fi

  cp -r "$controlslocation" "$backuppath"

  if [ $? -ne 0 ] ; then
    echo "USER folder backup failed, exiting"
    exit 1
  fi

  # delete shaders
  rm -rf "$shaderslocation"*

  # delete USER folder
  rm -rf "$controlslocation"

  echo "Finished SC cleanup"
}

echo "Do SC cleanup? (copies USER folder, deletes original USER folder and shaders)"
read answer

# if answer is not the same as answer with leading Y or y dropped; effecively - does answer start with Y/y
if [ "$answer" != "${answer#[Yy]}" ] ;then
    do_cleanup
else
    echo "Skipping SC cleanup"
fi
