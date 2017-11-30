#!/bin/sh

install () {
  apt-get update

  apt-get install docker-ce
  docker swarm init --advertise-addr=$(ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')

  apt-get install git-all

  DIRECTORY="prometheus-grafana-alertmanager-example"
  if [ -d "$DIRECTORY" ]; then
    rm -rf "$DIRECTORY"
  fi
  cd "$DIRECTORY"
  git clone https://github.com/PagerTree/prometheus-grafana-alertmanager-example.git

  chmod +x ./util/*.sh
  ./util/start.sh
}

install
