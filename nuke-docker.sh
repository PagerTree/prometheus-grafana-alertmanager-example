#!/bin/sh

docker rm -v $(docker ps -aq)
docker rmi $(docker images -q)
docker volume rm $(docker volume ls -q)
