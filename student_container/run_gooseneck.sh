#!/bin/bash

#run_gooseneck.sh
#Create a container with ip and port (may need to use docker compose)

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
  echo "Container $ucid found. Restarting..."
  docker restart $ucid
##Check if container exists
elif docker inspect "$ucid" > /dev/null 2>&1; then
    echo "Container $ucid is off. Powering on..."
    docker start $ucid
else
##Attempt to create new container
  echo "Container $ucid does not exist. Attempting to create..."
  docker run -d \
  --name $ucid \
  -p 2222:22 -p 5901:5901 -p 5902:5902 \
  -v ${ucid}_home_data:/home \
  -v ${ucid}_ssh_config:/etc/ssh \
  -v ${ucid}_var_lib_data:/var/lib \
  -v ${ucid}_var_log_data:/var/log \
  -v ${ucid}_var_www_data:/var/www \
  -v ${ucid}_opt_data:/opt \
  student_img
fi

