# ########################################################################
## @file Dockerfile
## @brief Gooseneck Student LXQT container image
## @details The student container Dockerfile that builds a default
##	student container. Based on Ubuntu 24.04 image. Use with a
##	script to give the container the name of a student's ucid.
# ########################################################################
## @details To-do list (Put in separate doc)
##	Give student access to web server (localhost)
##	Give readme for student to easily use this container
##	Give student account based on ucid (provided by db or api request)
##	Hide root priviliges
##	Give admin account
##	Give student limited sudo access.
# ########################################################################

FROM ubuntu:24.04

#Configure acl/linux permission set

## @brief Installs dependencies and configure permissions sets
## @details To-do list (Put in separate doc)
##	have ansible install/update packages.
##	rebuild image every x interval to maintain updates for students

##Full installs (core)
RUN apt-get update && apt-get install -y \
lxqt \
tigervnc-standalone-server \
tigervnc-common \
openssh-server \
dbus-x11 \
x11-xserver-utils \
snapd \
xterm \
curl \
build-essential \
wget \
ca-certificates \
git \
unzip \
zip \
python3 \
python3-pip \
python3-venv \
golang-go \
rustc \
cargo \
default-jdk \
nodejs \
npm \
git \
php \
postgresql \
mariadb-server \
vim \
neovim \
nano \
sudo \
openssh-client \
nginx \
net-tools \
iputils-ping \
wireshark \
nmap \
gfortran \
python3-pandas \
python3-numpy \
python3-matplotlib \
python3-scipy \
libreoffice \
gimp \
inkscape \
tcpdump \
iproute2 \
openssl \
falkon \
&& apt-get clean

#Load users from DB Test user
#Load Student DB webpages into dir
#Load config for ssh and x-utils

## @brief Setup SSH config with file
RUN mkdir -p /var/run/sshd

## @brief Create accounts with default passwords (WILL REPLACE WITH DB AND HASHES LATER)
## Can replace echo with file/DB substitutions later.
RUN echo "root:rootpass" | chpasswd

RUN useradd -m -s /bin/bash admin && \
    echo "admin:adminpass" | chpasswd && \
    usermod -aG sudo admin

RUN useradd -m -s /bin/bash student && \
    echo "student:studentpass" | chpasswd

# Give student ownership of website content (optional)
RUN mkdir -p /var/www/html && \
chown -R student:student /var/www/html

# Configure sudo permissions
RUN cat > /etc/sudoers.d/lab-users <<'EOF'
Cmnd_Alias NGINX_CMDS = \
/etc/init.d/nginx, \
/etc/init.d/nginx start, \
/etc/init.d/nginx stop, \
/etc/init.d/nginx restart, \
/etc/init.d/nginx reload, \
/etc/init.d/nginx status

admin ALL=(ALL:ALL) ALL
student ALL=(root) NGINX_CMDS
EOF

RUN chmod 440 /etc/sudoers.d/lab-users

#Copy config and entry point files
COPY sshd_config /etc/ssh/sshd_config
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY index.html /var/www/html/index.html

RUN chmod +x /usr/local/bin/entrypoint.sh

# SSH (22), Student VNC (5901), Admin VNC (5902)
EXPOSE 22 5901 5902

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

## @details To build container, use
## docker build --progress=plain -t student_img . | tee logs/build/student_img.log
##
## Include --no-cache for a full build and verbose log
##
##  To run container, use
## docker run -d --name student_env -p 2222:22 -p 5901:5901 -p 5902:5902 student_img
## 
## To-do (Make a script to run the container and name it)
