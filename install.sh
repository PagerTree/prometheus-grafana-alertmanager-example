#!/bin/sh

install () {
  apt-get update
  apt-get install docker-ce

  git clone https://github.com/PagerTree/prometheus-grafana-alertmanager-example.git
  cd prometheus-grafana-alertmanager-example

  chmod +x *.sh
  ./start.sh
  

}

install
