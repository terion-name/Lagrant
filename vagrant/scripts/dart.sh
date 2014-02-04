#!/usr/bin/env bash

echo "--- Installing DART ---"

sudo add-apt-repository ppa:hachre/dart
sudo apt-get update
sudo apt-get install dartsdk -y