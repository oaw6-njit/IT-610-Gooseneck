##

echo "Enter ucid of the container to be deleted: "
read -r ucid

#To do, filter out spaces and invalid names
if [[ -z "$ucid" ]]; then
  echo "No container specified."
  exit 1
fi

#Check if container is running
if docker ps --format '{{.Names}}' | grep -qx $ucid; then
  echo "Container $ucid is currently running. Please run stop_gooseneck.sh before proceeding."
  echo "Aborting..."
  exit 1
##Check if container exists
elif docker inspect "$ucid" > /dev/null 2>&1; then
  echo "Container $ucid found. Are you SURE you want to delete it (volumes will be saved)? (y/n)"
  read -r confirm
  if [[ $confirm == "y" ]]; then
    docker rm $ucid
    echo "Container $ucid deleted. Do you want to delete associated volumes (THIS CAN'T BE UNDONE!) (y/n)"
    read -r confirm2
    if [[ $confirm2 == "y" ]]; then
      docker volume rm ${ucid}_home_data
      docker volume rm ${ucid}_ssh_config
      docker volume rm ${ucid}_var_lib_data
      docker volume rm ${ucid}_var_log_data
      docker volume rm ${ucid}_var_www_data
      docker volume rm ${ucid}_opt_data
    elif [[ $confirm2 == "n" ]]; then
      echo "Will not delete $ucid containers. Exiting..."
      exit 1
    else
      echo "Invalid option. Will not delete $ucid containers. Exiting..."
      exit 1
    fi
  elif [[ $confirm == "n" ]]; then
    echo "Operation cancelled. Exiting..."
    exit 1
  else
    echo "Invalid option. Aborting..."
    exit 1
  fi
##If container does not exist, report error
else
  echo "Container $ucid does not exist. Exiting..."
  exit 1
fi
