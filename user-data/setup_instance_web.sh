#!/bin/bash

# Installing Required packages
sudo yum update -y && sudo yum apt update -y
sudo yum install scala -y

sudo amazon-linux-extras install docker -y
sudo systemctl start docker
sudo systemctl enable docker

# Installing docker compose
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Docker with mysql
sudo docker run -d -p 3306:3306 --name mysql --restart always -e "MYSQL_ROOT_PASSWORD=criminix" -e "MYSQL_DATABASE=criminix-clean" -e "MYSQL_USER=criminix" -e MYSQL_PASSWORD="criminix" mysql

setup_instance_web.sh