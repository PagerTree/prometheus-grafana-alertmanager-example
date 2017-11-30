#!/bin/sh
apt-get update

echo "Installing Docker"
apt-get -y install docker.io
apt-get -y install docker-ce

ADDRESS=$(ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
docker swarm init --advertise-addr="$ADDRESS"

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

echo "Waiting 5 seconds for services to come up"
sleep 5

while docker service ls | grep "0/1";  do sleep 3; echo "Waiting"; done;

echo "You can now access your Grafana dashboard at http://$ADDRESS:3000"
