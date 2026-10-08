#!/bin/bash

#stop_gooseneck.sh
#Stop a container with ip and port (may need to use docker compose)

#To-do list
#assign static ip
# keep track of ips set
# Free ip upon container deletion
# name container based on ucid argument
#change ucid and password based on arguments and sign in

read -r -p "Enter ucid: " ucid

#Check if valid (Remove spaces and special characters)

#Check if container is running
if docker ps --format '{{.Names}}' | grep -qx $ucid; then
  ##Stop VM
  echo "Stopping container $ucid..."
  docker stop $ucid
  exit 0
else
  echo "error: container with name $ucid not on/found. Exitting..."
  exit 2
fi

