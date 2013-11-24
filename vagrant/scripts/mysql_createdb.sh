#!/usr/bin/env bash

echo "--- Create MySQL database. ---"
DBNAME=$1
MYSQL_PASSWORD=$2
mysql --user=root --password="$MYSQL_PASSWORD" -Bse "CREATE DATABASE IF NOT EXISTS \`$DBNAME\` CHARACTER SET utf8 COLLATE utf8_general_ci"
