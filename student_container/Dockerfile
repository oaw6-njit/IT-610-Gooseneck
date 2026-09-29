##
# @file Dockerfile
# @brief Gooseneck Student LXQT container image
# To-do list (Put in separate doc)
# Give student a GUI interface for their container
# Give student access to web server (localhost)
# Give readme for student to easily use this container
# Give student account based on ucid (provided by db or api request)
# Hide root priviliges
# Give admin account
# Give student limited sudo access.

# To build container, use
# docker build -t student_image .

# To run container, use
# docker run -d --name student_env -p 2222:22 -p 5901:5901 -p 5902:5902 student_img
# (Make a script to run the container and name it)



FROM ubuntu:24.04

#Configure acl/linux permission set

##
# @brief Install dependencies and configure permissions sets
##

#To-do: Make install apps a loadable ini, filter out comments and error check.
COPY core.sh /core.sh
COPY core.ini /core.ini
RUN mkdir -p /logs/build
RUN touch /logs/build/student_build.log
RUN chmod 764 /core.sh

RUN /core.sh
ENV EXIT_CODE=$?
RUN if [ "$EXIT_CODE" -ne 0 ]; then \
	echo "Build failed with exit code $EXIT_CODE. Check your core.ini file."; \
	fi

#RUN ./apps.sh
#RUN ./app.config.sh

#RUN apt-get update && apt-get install -y \
#	lxqt \
#	tigervnc-standalone-server \
#	tigervnc-common \
#	openssh-server \
#	dbus-x11 \
#	x11-xserver-utils \
#	xterm \
#	curl \

#Load users from DB Test user
#Load Student DB webpages into dir
#Load config for ssh and x-utils

#Setup SSH config
RUN mkdir -p /var/run/sshd

#Create accounts with default passwords (WILL REPLACE WITH DB AND HASHES LATER)
#Can replace echo with file/DB substitutions later.
RUN echo "root:rootpass" | chpasswd

RUN useradd -m -s /bin/bash admin && \
    echo "admin:adminpass" | chpasswd && \
    usermod -aG sudo admin

RUN useradd -m -s /bin/bash student && \
    echo "student:studentpass" | chpasswd

#Copy config and entry point files
COPY sshd_config /etc/ssh/sshd_config
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

# SSH (22), Student VNC (5901), Admin VNC (5902)
EXPOSE 22 5901 5902

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]


