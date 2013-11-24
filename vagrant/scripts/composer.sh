#!/usr/bin/env bash

echo -n -n "--- Installing Composer ---"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer