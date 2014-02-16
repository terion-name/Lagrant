#!/usr/bin/env bash

echo "--- Instaling MariaDB ---"

MARIADB_PASSWORD=$1
MARIADB_VERSION=10

sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db

sudo add-apt-repository -y "deb http://mirrors.supportex.net/mariadb/repo/$MARIADB_VERSION/ubuntu precise main"

sudo apt-get update

sudo debconf-set-selections <<< "maria-db-$MARIADB_VERSION mysql-server/root_password password ${MARIADB_PASSWORD}"
sudo debconf-set-selections <<< "maria-db-$MARIADB_VERSION mysql-server/root_password_again password ${MARIADB_PASSWORD}"

sudo apt-get install -y mariadb-server mysql-client php5-mysql