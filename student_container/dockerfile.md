# Gooseneck Student Container Dockerfile

This Dockerfile builds an Ubuntu 24.04 image for the Gooseneck student desktop
container. It provides an LXQt desktop, development and end-user tools, a web
server, and SSH/VNC access. The entry point starts the configured services.
Container naming and UCID-based accounts are managed outside the image.

## Installed environment

The image installs the desktop, remote-access services, language toolchains,
networking utilities, and end-user applications in a single package-install
layer.

The Dockerfile explicitly installs these APT packages:

- Desktop and remote access: `lxqt`, `tigervnc-standalone-server`,
  `tigervnc-common`, `openssh-server`, `openssh-client`, `dbus-x11`,
  `x11-xserver-utils`, `xterm`
- System and networking: `snapd`, `sudo`, `nginx`, `net-tools`,
  `iputils-ping`, `iproute2`, `wireshark`, `nmap`, `tcpdump`, `openssl`
- Build tools and utilities: `build-essential`, `curl`, `wget`,
  `ca-certificates`, `git`, `unzip`, `zip`
- Language toolchains: `python3`, `python3-pip`, `python3-venv`, `golang-go`,
  `rustc`, `cargo`, `default-jdk`, `nodejs`, `npm`, `php`, `gfortran`
- Databases: `postgresql`, `mariadb-server`
- Python libraries: `python3-pandas`, `python3-numpy`,
  `python3-matplotlib`, `python3-scipy`
- Editors and applications: `vim`, `neovim`, `nano`, `libreoffice`, `gimp`,
  `inkscape`, `falkon`


## Accounts and web root

The build creates the runtime directory required by the SSH daemon, then creates
the `admin` and `student` accounts. The administrator belongs to the `sudo`
group. The web document root is `/var/www/html` and is owned by `student`.

> **Warning:** The configured root, administrator, and student passwords are
> placeholders and are not suitable for deployment. Replace them with a secure
> provisioning mechanism before exposing the image.

## Sudo permissions

The administrator receives unrestricted `sudo` access. The student is limited
to the listed NGINX service commands. The generated sudoers file is assigned
the permissions required by `sudo`.

## Configuration and startup

The image installs the SSH configuration, container entry point, and default
web page. It makes the entry-point script executable and starts the container
through that script.

## Exposed ports

| Service | Container port |
| --- | ---: |
| SSH | 22 |
| Student VNC | 5901 |
| Administrator VNC | 5902 |

## Build and run

Build the image and save the build log:

```sh
bash build_gooseneck.sh
```

The build script creates or refreshes the `student_img` Docker image from this
Dockerfile. It writes the output to a log file so you can review the build
progress and errors.

Run the container lifecycle script using the UCID as the container name:

```sh
bash run_gooseneck.sh
```

The script restarts a running container, starts an existing stopped container,
or creates a new container from `student_img`. A new container maps host ports
`2222`, `5901`, and `5902` to container ports `22`, `5901`, and `5902`, and
attaches named volumes for persistent data. These host ports must be available
when creating a container.

## Stop a container

To stop a running container, run the stop script and enter its UCID:

```sh
bash stop_gooseneck.sh
```

## Delete a container

To remove an existing container and its associated resources, run the delete
script and enter the UCID you want to delete:

```sh
bash delete_gooseneck.sh
```

The delete script removes the named container, any mapped host ports created by
that container, and the container's persistent data volume if it is no longer
needed.
