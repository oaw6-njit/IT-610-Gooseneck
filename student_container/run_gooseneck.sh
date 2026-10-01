#!/bin/bash

#run_gooseneck.sh
#Create a container with ip and port (may need to use docker compose)

#To-do list
#assign static ip
# keep track of ips set
# Free ip upon container deletion
# name container based on ucid argument
#change ucid and password based on arguments and sign in

read -p "Enter ucid: " ucid

#Check if valid (Remove spaces and special characters)

#Check if container is running
if docker ps --format '{{.Names}}' | grep -qx $ucid; then
##Restart VM
docker restart $ucid
else
##Run
docker run -d --name $ucid -p 2222:22 -p 5901:5901 -p 5902:5902 student_img
fi

