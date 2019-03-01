#!/bin/sh
script=$0
$(dirname "$script")/stop.sh
sleep 5
$(dirname "$script")/start.sh
