#!/usr/bin/env bash

# SHOULD BE RUN AFTER PHP INSTALL

echo -n "--- Installing MongoDB ---"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo -n 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo apt-get install mongodb-10gen
sudo /etc/init.d/mongodb start

echo -n "--- MongoDB PHP extension ---"
sudo pecl install mongo
sudo sh -c 'echo -n "extension=mongo.so" >> /etc/php5/fpm/php.ini'