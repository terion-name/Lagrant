#!/usr/bin/env bash

echo "--- Updating packages list ---"

# echo "deb http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list
# echo "deb-src http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list

echo "deb http://packages.dotdeb.org wheezy-php55 all" >> /etc/apt/sources.list
echo "deb-src http://packages.dotdeb.org wheezy-php55 all" >> /etc/apt/sources.list

wget http://www.dotdeb.org/dotdeb.gpg
sudo apt-key add dotdeb.gpg
sudo apt-get update

echo "--- Installing base packages ---"
sudo apt-get install -y vim curl git-core build-essential openssl libssl-dev python-software-properties python g++ make