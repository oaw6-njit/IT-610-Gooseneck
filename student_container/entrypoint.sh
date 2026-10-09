#!/usr/bin/env bash

## @file entrypoint.sh
## @brief Starts the container's SSH and VNC services on launch.
## @details
## This script configures a VNC session for the configured system users,
## generates any missing SSH host keys, starts the SSH service, launches the
## TigerVNC servers for the student and admin accounts, and then keeps the
## container alive by tailing /dev/null.

## Stop the script on any non-zero exit code.
set -e

## @brief Configure the VNC directory and startup script for a given user.
## @param username The Linux user account to configure.
## @param password The VNC password to set for that user.
## @details Creates the ~/.vnc directory, writes the password file, installs
##          the xstartup script that launches the desktop session, and sets
##          ownership for the VNC configuration.
setup_vnc() {
    local username=$1
    local password=$2
    local user_home
    user_home=$(eval echo "~$username")

    mkdir -p "$user_home/.vnc"

    ## Set VNC password
    echo "$password" | vncpasswd -f > "$user_home/.vnc/passwd"
    chmod 600 "$user_home/.vnc/passwd"

    ## Write desktop session startup script
    cat << 'EOF' > "$user_home/.vnc/xstartup"
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
exec startlxqt
EOF

    chmod +x "$user_home/.vnc/xstartup"
    chown -R "$username:$username" "$user_home/.vnc"
}

## Configure VNC for the student and admin users.
## @note The default passwords can be overridden with STUDENT_PASSWORD and
##       ADMIN_PASSWORD environment variables when the container starts.
setup_vnc "student" "${STUDENT_PASSWORD:-studentpass}"
setup_vnc "admin" "${ADMIN_PASSWORD:-adminpass}"

## Generate any missing SSH host keys before starting the daemon.
ssh-keygen -A

## Start the SSH daemon so remote access is available inside the container.
service ssh start

## Start TigerVNC servers for both users.
## @note Student session: :1 (port 5901) and admin session: :2 (port 5902).
su - student -c "vncserver :1 -geometry 1280x720 -depth 24 -localhost no"
su - admin -c "vncserver :2 -geometry 1280x720 -depth 24 -localhost no"

## Keep the container alive while the VNC and SSH services run in the background.
exec tail -f /dev/null
