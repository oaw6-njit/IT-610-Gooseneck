FROM ubuntu:24.04

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

RUN mkdir -p /var/run/sshd

RUN echo "root:rootpass" | chpasswd

RUN useradd -m -s /bin/bash admin && \
    echo "admin:adminpass" | chpasswd && \
    usermod -aG sudo admin

RUN useradd -m -s /bin/bash student && \
    echo "student:studentpass" | chpasswd

RUN mkdir -p /var/www/html && \
chown -R student:student /var/www/html

RUN cat > /etc/sudoers.d/lab-users <<'EOF'
Cmnd_Alias NGINX_CMDS = \
/etc/init.d/nginx start, \
/etc/init.d/nginx stop, \
/etc/init.d/nginx restart, \
/etc/init.d/nginx reload, \
/etc/init.d/nginx status

admin ALL=(ALL:ALL) ALL
student ALL=(root) NGINX_CMDS
EOF

RUN chmod 440 /etc/sudoers.d/lab-users

COPY sshd_config /etc/ssh/sshd_config
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY index.html /var/www/html/index.html

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 22 5901 5902

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
