#!/bin/bash
## @file run_gooseneck.sh
## @brief Start or restart a student's Gooseneck container by UCID.
## @details This script checks whether a Docker container with the supplied UCID
##          is already running. If it is active, the container is restarted. If it
##          exists but is currently stopped, it is started. Otherwise, a new
##          container is created from the student_img image using the UCID as the
##          container name.
## @note The UCID should be a simple identifier with no spaces or special characters.

## Prompt for the user's UCID to identify the target container.
read -r -p "Enter ucid: " ucid

## Validate the supplied UCID before using it in Docker commands.
## Additional sanitization may be added here if stricter input validation is needed.

## Check whether the container is currently running.
if docker ps --format '{{.Names}}' | grep -qx "$ucid"; then
  echo "Container $ucid found. Restarting..."
  docker restart "$ucid"

## Check whether the container already exists but is currently stopped.
elif docker inspect "$ucid" > /dev/null 2>&1; then
  echo "Container $ucid is off. Powering on..."
  docker start "$ucid"

## Create a new container if no matching Docker object exists.
else
  echo "Container $ucid does not exist. Attempting to create..."
  docker run -d \
    --name "$ucid" \
    -p 2222:22 \
    -p 5901:5901 \
    -p 5902:5902 \
    -v "${ucid}_home_data:/home" \
    -v "${ucid}_ssh_config:/etc/ssh" \
    -v "${ucid}_var_lib_data:/var/lib" \
    -v "${ucid}_var_log_data:/var/log" \
    -v "${ucid}_var_www_data:/var/www" \
    -v "${ucid}_opt_data:/opt" \
    student_img
fi

