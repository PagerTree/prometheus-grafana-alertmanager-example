#!/bin/sh
script=$0

sed -i "s|https://ngrok.io|$1|" $(dirname "$script")/../alertmanager/config.yml
