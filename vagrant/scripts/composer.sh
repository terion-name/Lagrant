#!/usr/bin/env bash

echo "--- Installing Composer ---"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
export PATH=~/.composer/vendor/bin:$PATH
