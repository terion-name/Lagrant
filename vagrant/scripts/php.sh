#!/usr/bin/env bash

echo "--- Installing PHP and packages ---"
sudo add-apt-repository ppa:ondrej/php5
sudo apt-get update
sudo apt-get install -y php5-dev php5-cli php-pear php5-curl php5-gd php5-mcrypt