#!/usr/bin/env bash

echo "--- Instaling HHVM ---"

wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | sudo apt-key add -
sudo add-apt-repository -y "deb http://dl.hhvm.com/ubuntu precise main"

sudo apt-get update

sudo apt-get -y install hhvm