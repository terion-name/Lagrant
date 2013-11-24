#!/usr/bin/env bash

echo "--- Instaling MySQL ---"

MYSQL_PASSWORD=$1

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password ${MYSQL_PASSWORD}"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${MYSQL_PASSWORD}"

sudo apt-get install -y mysql-server mysql-client php5-mysql