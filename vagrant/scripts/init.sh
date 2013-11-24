#!/usr/bin/env bash

echo "--- Updating packages list ---"

# deb http://packages.dotdeb.org wheezy all
# deb-src http://packages.dotdeb.org wheezy all

deb http://packages.dotdeb.org wheezy-php55 all
deb-src http://packages.dotdeb.org wheezy-php55 all

wget http://www.dotdeb.org/dotdeb.gpg
sudo apt-key add dotdeb.gpg
sudo apt-get update

echo "--- Installing base packages ---"
sudo apt-get install -y vim curl git-core build-essential openssl libssl-dev python-software-properties python g++ make