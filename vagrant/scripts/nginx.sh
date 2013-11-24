#!/usr/bin/env bash

# SHOULD BE RUN AFTER PHP INSTALL

echo -n "--- Installing NGINX ---"
sudo apt-get install -y nginx

echo -n "--- Change Nginx to listen to php5 socket ---"
sed -i "s/listen = 127.0.0.1:9000/listen = \/tmp\/php5-fpm.sock/" /etc/php5/fpm/pool.d/www.conf

echo -n "--- Replace old default Nginx vhost ---"
sudo rm /etc/nginx/sites-available/default
sudo cp /vagrant/vagrant/configs/nginx-vhost /etc/nginx/sites-available/default

echo -n "--- Restart Nginx && PHP5-FPM ---"
sudo service php5-fpm restart
sudo service nginx restart