#!/bin/bash
## @file delete_gooseneck.sh
## @brief Delete a Gooseneck container and optionally its associated volumes.
## @details This script prompts for a UCID, checks that the container exists and is
##          not running, and then asks for confirmation before removing it. It can
##          also delete the named Docker volumes that store the container data.
## @warning Removing Docker volumes is permanent and cannot be undone.

## Prompt for the UCID of the container to remove.
echo "Enter ucid of the container to be deleted: "
read -r ucid

## Ensure that a valid UCID was provided before continuing.
if [[ -z "$ucid" ]]; then
  echo "No container specified."
  exit 1
fi

## Check whether the container is still running and must be stopped first.
if docker ps --format '{{.Names}}' | grep -qx "$ucid"; then
  echo "Container $ucid is currently running. Please run stop_gooseneck.sh before proceeding."
  echo "Aborting..."
  exit 1

## If the container exists but is stopped, continue with deletion.
elif docker inspect "$ucid" > /dev/null 2>&1; then
  echo "Container $ucid found. Are you SURE you want to delete it (volumes will be saved)? (y/n)"
  read -r confirm

  if [[ "$confirm" == "y" ]]; then
    docker rm "$ucid"
    echo "Container $ucid deleted. Do you want to delete associated volumes (THIS CAN'T BE UNDONE!) (y/n)"
    read -r confirm2

    if [[ "$confirm2" == "y" ]]; then
      docker volume rm "${ucid}_home_data"
      docker volume rm "${ucid}_ssh_config"
      docker volume rm "${ucid}_var_lib_data"
      docker volume rm "${ucid}_var_log_data"
      docker volume rm "${ucid}_var_www_data"
      docker volume rm "${ucid}_opt_data"
    elif [[ "$confirm2" == "n" ]]; then
      echo "Will not delete $ucid containers. Exiting..."
      exit 1
    else
      echo "Invalid option. Will not delete $ucid containers. Exiting..."
      exit 1
    fi
  elif [[ "$confirm" == "n" ]]; then
    echo "Operation cancelled. Exiting..."
    exit 1
  else
    echo "Invalid option. Aborting..."
    exit 1
  fi

## If no Docker container matches the UCID, report the missing object.
else
  echo "Container $ucid does not exist. Exiting..."
  exit 1
fi
