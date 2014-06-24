#!/usr/bin/env bash

echo "--- Instaling PhpMyAdmin ---"

MYSQL_PASSWORD=$1

sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password ${MYSQL_PASSWORD}"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password ${MYSQL_PASSWORD}"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password ${MYSQL_PASSWORD}"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none"

sudo apt-get install -y phpmyadmin

# Patch nginx config

REPLACE_ANCHOR='#place-more-options-here'
PHPMYADMIN_NG_CONFIG='include \/etc\/nginx\/phpmyadmin;'
REPLACE_STR=$PHPMYADMIN_NG_CONFIG"\n"$REPLACE_ANCHOR

sudo cp /vagrant/vagrant/configs/nginx/phpmyadmin /etc/nginx/phpmyadmin
sudo sed -i "s/$REPLACE_ANCHOR/$REPLACE_STR/" /etc/nginx/sites-available/default

# Patch phpmyadmin config
# 1 - respect localhost:8080/phpmyadmin
# 2 - skipp login page

REPLACE_ANCHOR="\$cfg\['Servers'\]\[\$i\]\['auth_type'\] = 'cookie';"
REPLACE_STR="\$cfg['Servers'][\$i]['auth_type'] = 'config';\n\$cfg['Servers'][\$i]['user'] = 'root';\n\$cfg['Servers'][\$i]['password'] = '${MYSQL_PASSWORD}';"

sudo sed -i "s/$REPLACE_ANCHOR/$REPLACE_STR/" /etc/phpmyadmin/config.inc.php

echo "\$cfg['PmaAbsoluteUri'] = 'http://localhost:8080/phpmyadmin/';" >> /etc/phpmyadmin/config.inc.php

sudo service nginx restart
