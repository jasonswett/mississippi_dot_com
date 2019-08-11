#!/bin/bash

yum install -y git-core

cd /home/ec2-user
git clone https://github.com/jasonswett/mississippi_dot_com.git
cd mississippi_dot_com

yum install docker -y
curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

service docker start
docker-compose up -d
docker-compose run web rails db:create
