#!/usr/bin/env bash

echo "--- Link vagrant to document root ---"
sudo rm -rf /var/www
sudo ln -fs /vagrant /var/www