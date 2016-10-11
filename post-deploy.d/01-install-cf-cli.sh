#!/bin/sh
if [ ! -f /usr/bin/cf ]; then
    wget -q "https://cli.run.pivotal.io/stable?release=debian64&version=6.22.1&source=github-rel" -O cf-cli.deb
    dpkg -i ./cf-cli.deb && apt-get install -f
fi
