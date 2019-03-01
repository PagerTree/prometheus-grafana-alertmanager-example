#!/bin/sh
script=$0
$(dirname "$script")/stop.sh
sleep 5
docker rm -v $(docker ps -f "name=prom" -aq)
docker volume rm $(docker volume ls -f "name=prom" -q)
