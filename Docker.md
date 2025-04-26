# docker-cheatseet
Common commands neededs

# Install

sudo apt install apt-transport-https ca-certificates curl software-properties-common && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" && apt-cache policy docker-ce && sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose -y


# Create Instance
  
  docker container run --name test_deb -it debian bash

# Run Instance

  docker container start -ai test_deb

# Stop All Containers

docker stop $(docker ps -q)
<br>
<a target='_blank' href='https://www.unixtutorial.org/docker-stop-all-containers/'>Detail</a>

# Multiple Command

<br>
  need to start daemon before
<br>

docker exec debian2 "uname";"uname";ip addr;"uname"

# Exec specific command and return data

docker container exec -it container1 ifconfig

# Delete All Stopped

docker container prune -f

# Mapd Dir

docker container run --name test_deb -v /home/felipe/apache:/var/www/html  -it debian bash

# Daemon

docker start test_deb

# Remove All Images

docker system prune -a
<br>
<a href='https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes#removing-volumes'>Detail</a>

# Build from Dockerfile

docker image build -t somedebian .

# Get volume from another container

docker container run -it --volumes-from=9be2b7cb66ad debian cat /log/http-server.log

# Dockerfile for map port by default

FROM python:3.6 <br>
LABEL manteiner="Aluno" <br>
RUN useradd www && \ <br>
    mkdir /app && \ <br>
    mkdir /log && \ <br>
    chown www /log && \ <br> 
    apt install python3 -y <br>
 <br>
USER www <br>
VOLUME /log <br>
WORKDIR /app <br>
EXPOSE 8095 <br>
ENTRYPOINT [ "/usr/bin/python3"] <br>
CMD [ "run.py" ] <br>


# Push on DockerHub

docker image tag lamp_debian felipesms/lamp_debian:1.0 <br>
(tag the image alias 'lamp_deb') <br>
docker image push felipesms/lamp_debian:1.0 


# Network

 docker container run -d --net none felipesms/lamp_debian:1.0
 <br>
 (network host if want to use the same real interface)
 <br>
 
 <strrong>List Network</strong>
 <br>
 docker network ls
 <br>
 <strong>Inspect some specific network</strong>
<br>
 docker inspect network bridge


# Create new network

docker network create --driver bridge new_network

# Connections between networks
  <br>
docker network connect bridge container3
<br>
(for disconnect just change verb disconnect)


# Run without sudo 

sudo usermod -aG docker $USER && newgrp docker

# Assign Port to existing

<a href='https://stackoverflow.com/questions/19335444/how-do-i-assign-a-port-mapping-to-an-existing-docker-container'>https://stackoverflow.com/questions/19335444/how-do-i-assign-a-port-mapping-to-an-existing-docker-container</a>


 
 
# Docker composer file sample

(<a href='https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/Simple-Apache-docker-compose-example-with-Dockers-httpd-image' target='_blank'>website</a>)

version: '3.9'
services:
  apache:
    image: httpd:latest
    container_name: my-apache-app
    ports:
    - '8080:80'
    volumes:
    - ./website:/usr/local/apache2/htdocs

# One Script install

curl -fsSL https://get.docker.com | sh ; sudo usermod -aG docker ${USER}; su - ${USER} ; id -nG ; sudo usermod -aG docker ${USER}


# Container Orchestration




    
