#!/usr/bin/env bash

echo "--- Updating packages list ---"

sudo apt-get update

echo "--- Installing base packages ---"
sudo apt-get install -y vim curl git-core build-essential openssl libssl-dev python-software-properties python g++ make