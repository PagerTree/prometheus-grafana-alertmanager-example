#!/bin/sh

install () {
  apt-get update

  apt-get -y install docker.io
  apt-get -y install docker-ce
  docker swarm init --advertise-addr=$(ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')

  apt-get -y install git

  DIRECTORY="prometheus-grafana-alertmanager-example"
  if [ -d "$DIRECTORY" ]; then
    rm -rf "$DIRECTORY"
  fi
  git clone https://github.com/PagerTree/prometheus-grafana-alertmanager-example.git
  cd "$DIRECTORY"

  chmod +x ./util/*.sh
  ./util/start.sh
}

install
