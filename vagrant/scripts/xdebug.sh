#!/usr/bin/env bash

echo "--- Installing and configuring Xdebug ---"
sudo apt-get install -y php5-xdebug

# this install method sets xdebug.scream to 1
# and this breaks laravel
sudo sed -i "s/xdebug.scream=1/xdebug.scream=0/" /etc/php5/mods-available/xdebug.ini