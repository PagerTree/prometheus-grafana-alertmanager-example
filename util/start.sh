#!/bin/sh
script=$0
docker stack deploy -c $(dirname "$script")/../docker-compose.yml prom
sleep 3
$(dirname "$script")/status.sh
