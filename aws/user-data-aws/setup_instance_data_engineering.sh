#!/bin/bash

# Installing Required packages
sudo yum update -y && sudo yum apt update -y

sudo amazon-linux-extras install docker -y
sudo systemctl start docker
sudo systemctl enable docker

# Installing docker compose
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Docker with jupyter
sudo docker run -it --name jupyter --restart always -p 8888:8888 -v "/root":/home/ec2-user jupyter/pyspark-notebook start.sh jupyter lab --port 8888 --allow-root --no-browser --ip 0.0.0.0 --ServerApp.token='criminix' --LabApp.token='criminix' --ServerApp.password='argon2:$argon2id$v=19$m=10240,t=10,p=8$+ahgkVR9EBlqliMi1q7lVA$4KjlCQDE3MOi7Z0u7DwNmNDU/Kj+ofir9NgyDlDQogg' 

# Create file airflow
sudo mkdir /opt/airflow
sudo mkdir /opt/airflow/plugins
sudo mkdir /opt/airflow/dags
sudo mkdir /opt/airflow/logs

# Permissions in folders for airflow
sudo chmod 777 /opt/airflow
sudo chmod 777 /opt/airflow/plugins
sudo chmod 777 /opt/airflow/dags
sudo chmod 777 /opt/airflow/logs

sudo curl https://airflow.apache.org/docs/apache-airflow/2.6.1/docker-compose.yaml --output /opt/airflow/docker-compose.yaml
cd /opt/airflow/
sudo docker-compose up -d

setup_instance_data_engineering.sh