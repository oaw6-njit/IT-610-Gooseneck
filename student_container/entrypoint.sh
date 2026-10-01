#!/usr/bin/env bash

## @brief Entrypoint.sh
#Setup VNC server on container launch.

#Stop script upon ANY non-zero exit code
set -e

# Helper to configure VNC directory and startup scripts per user
setup_vnc() {
    local username=$1
    local password=$2
    local user_home
    user_home=$(eval echo "~$username")

    mkdir -p "$user_home/.vnc"

    # Set VNC password
    echo "$password" | vncpasswd -f > "$user_home/.vnc/passwd"
    chmod 600 "$user_home/.vnc/passwd"

    # Write desktop session startup script
    cat << 'EOF' > "$user_home/.vnc/xstartup"
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
exec startlxqt
EOF

    chmod +x "$user_home/.vnc/xstartup"
    chown -R "$username:$username" "$user_home/.vnc"
}

# Configure VNC for student and admin users
setup_vnc "student" "${STUDENT_PASSWORD:-studentpass}"
setup_vnc "admin" "${ADMIN_PASSWORD:-adminpass}"

# Generate SSH host keys if missing
ssh-keygen -A

# Start SSH daemon
service ssh start

# Start TigerVNC servers (Student on :1 / Port 5901, Admin on :2 / Port 5902)
su - student -c "vncserver :1 -geometry 1280x720 -depth 24 -localhost no"
su - admin -c "vncserver :2 -geometry 1280x720 -depth 24 -localhost no"

# Keep the container running
exec tail -f /dev/null
