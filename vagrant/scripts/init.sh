#!/usr/bin/env bash

ENV_NAME=$1

echo "--- Setting up hostname ---"
sudo rm /etc/hostname
sudo sh -c 'echo "$ENV_NAME" >> /etc/hostname'
sudo /etc/init.d/hostname.sh start
echo hostname

echo "--- Updating packages list ---"

sudo apt-get update

echo "--- Installing base packages ---"
sudo apt-get install -y vim curl git-core build-essential openssl libssl-dev python-software-properties python g++ make zip unzip