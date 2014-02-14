#!/usr/bin/env bash

echo "--- Installing SASS and Compass ---"

sudo apt-get install -y ruby-sass
sudo gem update --system
sudo gem install compass