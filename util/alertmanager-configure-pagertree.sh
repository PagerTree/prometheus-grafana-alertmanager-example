#!/bin/sh
sed -i "s|https://ngrok.io|$1|" ./alertmanager/config.yml
