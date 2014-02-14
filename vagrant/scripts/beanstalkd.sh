#!/usr/bin/env bash

# MUST BE INSTALLED AFTER NGINX

echo "--- Installing Beanstalkd ---"
sudo apt-get install -y beanstalkd

echo "--- Installing Beanstalk Console ---"

# Install console
mkdir /home/vagrant/beanstalk-console
composer create-project ptrofimov/beanstalk_console -s dev /home/vagrant/beanstalk-console

# Uncomment localhost in config
sed -i "s/\/\*'localhost:11300'\*\//'localhost:11300'/" /home/vagrant/beanstalk-console/config.php

# Patch nginx config

REPLACE_ANCHOR='#place-more-options-here'
BEANSTALK_CONFIG='include \/etc\/nginx\/beanstalk;'
REPLACE_STR=$BEANSTALK_CONFIG"\n"$REPLACE_ANCHOR

sudo cp /vagrant/vagrant/configs/nginx/beanstalk /etc/nginx/beanstalk
sudo sed -i "s/$REPLACE_ANCHOR/$REPLACE_STR/" /etc/nginx/sites-available/default

# Enable autostart

sudo sed -i "s/#START=yes/START=yes/" /etc/default/beanstalkd

# Run it

sudo service nginx restart
sudo service beanstalkd restart