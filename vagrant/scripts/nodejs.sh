#!/usr/bin/env bash

echo "--- Installing NodeJS ---"
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install nodejs
curl -3 https://npmjs.org/install.sh | sudo sh