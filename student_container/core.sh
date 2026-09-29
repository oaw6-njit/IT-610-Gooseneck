#/bin/bash

#Core.sh
#Load core container applications (LXDT, VNC, etc.)
#Can only be configured by admin/root

#update repository
apt-get update

apps_total=$(wc -l < /core.ini)
apps_installed=0
log_file=/logs/build/student_build.log

#Read through core.ini
#Install if valid, skip if not
#Track and log all installed files.

while IFS= read -r app; do
  # Skip empty lines or comments
  [[ -z "$app" || "$app" =~ ^# ]] && continue
  # Install if package name is valid
  if apt-cache show $app &>/dev/null; then
    echo "Installing $app..."
    apt-get install -y "$app"
    #Check install exit status
    if [ $? -eq 0 ]; then
      apps_installed++
      echo "Installed $app ($apps_installed/$apps_total)." | tee -a $log_file
    else
      echo "Failed to install $app. Check your core.ini file. Exitting... ($apps_installed/$apps_total)." | tee -a $log_file
      return 200
    fi
  else
    echo "Package $app does not exist. Check your core.ini file. Exitting... ($apps_installed/$apps_total)" | tee -a $log_file
    return 100
  fi
done < /core.ini
