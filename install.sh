#!/bin/sh
apt-get update

if ! type "docker" > /dev/null; then
  echo "Installing Docker"
  apt-get -y install docker.io
  apt-get -y install docker-ce
fi

ADDRESS=$(ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
docker swarm init --advertise-addr="$ADDRESS"

if ! type "git" > /dev/null; then
  echo "Installing Git"
  apt-get -y install git
fi

DIRECTORY="prometheus-grafana-alertmanager-example"
if [ -d "$DIRECTORY" ]; then
  rm -rf "$DIRECTORY"
fi
echo "Cloning Project"
git clone --single-branch --branch grafana-5.4.2 https://github.com/PagerTree/prometheus-grafana-alertmanager-example.git
cd "$DIRECTORY"

echo "Making Utility scripts executable"
chmod +x ./util/*.sh

echo "Starting Application"
docker stack deploy -c docker-compose.yml prom

echo "Waiting 5 seconds for services to come up"
sleep 5

while docker service ls | grep "0/1";  do sleep 3; echo "Waiting..."; done;

echo "You can now access your Grafana dashboard at http://$ADDRESS:3000"
