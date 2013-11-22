#!/usr/bin/env bash

echo "--- Installing PHP and packages ---"
sudo apt-get install -y php5-dev php5-fpm php5-cli php-pear php5-curl php5-gd php5-mcrypt mysql-server mysql-client php5-mysql
sudo pecl install mongo
sudo sh -c 'echo "extension=mongo.so" >> /etc/php5/fpm/php.ini'

echo "--- Turn error reporting on ---"
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/fpm/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/fpm/php.ini