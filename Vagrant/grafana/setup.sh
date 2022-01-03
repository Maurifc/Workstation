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

# Run Influx
docker volume create influxdb
docker container run -d --restart always --mount type=volume,src=influxdb,dst=/var/lib/influxdb --name influx -p 8083:8083 -p 8086:8086 -p 25826:25826/udp --network grafana_net influxdb:1.0

# Install Telegraf Locally
curl -s https://repos.influxdata.com/influxdb.key | sudo tee /etc/apt/trusted.gpg.d/influxdb.asc >/dev/null
source /etc/os-release
echo "deb https://repos.influxdata.com/${ID} ${VERSION_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
sudo apt-get update && sudo apt-get install telegraf