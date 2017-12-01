#!/bin/sh
sed -i "s|<PagerTree WebHook URL>|$1|" ./alertmanager/config.yml
