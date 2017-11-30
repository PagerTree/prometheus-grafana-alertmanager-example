#!/bin/sh
docker stack deploy -c docker-compose.yml prom
sleep 3
./util/status.sh
