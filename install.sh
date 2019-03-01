#!/bin/sh
apt-get update

if ! type "docker" > /dev/null; then
  echo "Installing Docker"
  apt-get -y install docker.io
  apt-get -y install docker-ce
fi

# get ips | search inet addr: | split on : get 2nd field | print out
ADDRESS=$(ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
# if we have an emtpy address
if [[ -z "${ADDRESS}"]]; then
  # some prints won't have the addr portion, do a last ditch effort to get the ip
  # get ips | search inet | get first line | trim string | split on ' ' get the 2nd field | print out
  ADDRESS=$(ifconfig eth0 | grep 'inet' | awk 'NR == 1' | awk '{$1=$1};1' | cut -d ' ' -f 2 | awk '{ print $1}')
fi
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
git clone https://github.com/PagerTree/prometheus-grafana-alertmanager-example.git
cd "$DIRECTORY"

echo "Making Utility scripts executable"
chmod +x ./util/*.sh

echo "Starting Application"
docker stack deploy -c docker-compose.yml prom

echo "Waiting 5 seconds for services to come up"
sleep 5

while docker service ls | grep "0/1";  do sleep 3; echo "Waiting..."; done;

echo "You can now access your Grafana dashboard at http://$ADDRESS:3000"
