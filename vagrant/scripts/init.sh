#!/usr/bin/env bash

echo -n "--- Updating packages list ---"
sudo apt-get update

echo -n "--- Installing base packages ---"
sudo apt-get install -y vim curl git-core build-essential openssl libssl-dev python-software-properties python g++ make