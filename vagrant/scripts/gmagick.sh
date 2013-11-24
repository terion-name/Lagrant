#!/usr/bin/env bash

# SHOULD BE RUN AFTER PHP INSTALL

echo "--- Installing gmagick ---"
sudo apt-get install -y graphicsmagick libgraphicsmagick1-dev
sudo pecl install gmagick-1.1.4RC1
sudo sh -c 'echo "extension=gmagick.so" >> /etc/php5/fpm/php.ini'