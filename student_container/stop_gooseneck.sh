#!/bin/bash
## @file stop_gooseneck.sh
## @brief Stop a running Gooseneck container for the supplied UCID.
## @details The script prompts for a UCID, verifies the matching container is
##          currently running, and then stops it cleanly.
## @warning If the container is not running or cannot be found, the script exits
##          with an error code.

## Prompt for the UCID of the container to stop.
read -r -p "Enter ucid: " ucid

## Validate the user input before using it in Docker commands.
## Additional sanitization may be added here if stricter input validation is needed.

## Check whether the matching container is currently running.
if docker ps --format '{{.Names}}' | grep -qx "$ucid"; then
  echo "Stopping container $ucid..."
  docker stop "$ucid"
  exit 0
else
  echo "error: container with name $ucid not on/found. Exiting..."
  exit 2
fi

