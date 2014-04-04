#!/usr/bin/env bash

# SHOULD BE RUN AFTER PHP INSTALL

echo "--- Installing MongoDB ---"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo apt-get install mongodb-10gen
sudo /etc/init.d/mongodb start

echo "--- MongoDB PHP extension ---"
sudo apt-get install libsasl2-dev
sudo pecl install mongo -y
sudo sh -c 'echo "extension=mongo.so" >> /etc/php5/fpm/php.ini'
sudo sh -c 'echo "extension=mongo.so" >> /etc/php5/cli/php.ini'
