#!/usr/bin/env bash

echo -n "--- Instaling MySQL ---"

MYSQL_PASSWORD = $1

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password ${MYSQL_PASSWORD}"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${MYSQL_PASSWORD}"