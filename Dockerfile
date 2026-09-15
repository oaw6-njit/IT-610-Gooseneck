#Gooseneck File Server Dockerfile
FROM ubuntu:24.04

#Configure acl/linux permission set

#Install dependencies and configure permissions sets
#nginx
#openssh server
RUN apt-get update && apt-get install -y \
	nginx \
	openssh-server

#Load users from DB Test user
#Load Student DB webpages into dir
COPY index.html /var/www/html/
#RUN useradd

#Start and configure SSH server
# Either import SSH config file from project dir or manually sed file

#Start and configure web server
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

#To run server,
#docker run -d -p 8080:80 <container_name>

