#!/bin/sh
docker exec -t -i $(docker ps -aqf "name=prom_$1") /bin/bash
