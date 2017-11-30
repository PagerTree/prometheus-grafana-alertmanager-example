#!/bin/sh
docker stack deploy -c docker-compose.yml prom
./util/status.sh
