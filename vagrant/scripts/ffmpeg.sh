#!/usr/bin/env bash

echo "--- Installing FFMPEG ---"
sudo add-apt-repository ppa:samrog131/ppa
sudo apt-get update
sudo apt-get install -y ffmpeg