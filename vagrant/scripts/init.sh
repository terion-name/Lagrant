#!/usr/bin/env bash

ENV_NAME=$1

echo "--- Setting up hostname ---"
sudo rm /etc/hostname
sudo echo "$ENV_NAME" >> /etc/hostname
sudo echo "127.0.1.1       $ENV_NAME" >> /etc/hosts
sudo hostname $ENV_NAME
hostname

echo "--- Updating packages list ---"

sudo apt-get update

echo "--- Installing base packages ---"
sudo apt-get install -y vim curl git-core build-essential openssl libssl-dev python-software-properties python g++ make zip unzip