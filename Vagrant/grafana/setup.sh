#!/bin/bash

# Updates
apt update && apt upgrade -y

# Docker Install
curl -fsSL https://get.docker.com | sudo bash
sudo curl -fsSL "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo usermod -aG docker vagrant

# Run Grafana
docker volume create grafana
docker network create grafana_net
docker container run -d -p 3000:3000 --user 999 --mount type=volume,src=grafana,dst=/var/lib/grafana --network=grafana_net --restart=always --name grafana grafana/grafana-oss