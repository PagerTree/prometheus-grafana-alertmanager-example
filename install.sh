#!/bin/sh
apt-get update

echo "Installing Docker"
apt-get -y install docker.io
apt-get -y install docker-ce
docker swarm init --advertise-addr=$(ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')

echo "Installing Git"
apt-get -y install git

DIRECTORY="prometheus-grafana-alertmanager-example"
if [ -d "$DIRECTORY" ]; then
  rm -rf "$DIRECTORY"
fi
echo "Cloning Project"
git clone https://github.com/PagerTree/prometheus-grafana-alertmanager-example.git
cd "$DIRECTORY"

echo "Making Utility scripts executable"
chmod +x ./util/*.sh

echo "Starting Application"
docker stack deploy -c docker-compose.yml prom

while docker service ls | grep "0/1"; do sleep 5; echo "Waiting 5 seconds for services to come up"; done;
