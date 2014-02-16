#!/usr/bin/env bash

echo "--- Instaling PostgreSQL ---"

POSTGRESQL_PASSWORD=$1
POSTGRESQL_VERSION=10

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

sudo add-apt-repository -y "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main"
sudo apt-get update
sudo apt-get install -y postgresql postgresql-contrib

sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/$POSTGRE_VERSION/main/postgresql.conf

echo "host    all             all             0.0.0.0/0               md5" | sudo tee -a /etc/postgresql/$POSTGRESQL_VERSION/main/pg_hba.conf

sudo service postgresql start
sudo -u postgres psql -c "CREATE ROLE root LOGIN UNENCRYPTED PASSWORD '$POSTGRESQL_PASSWORD' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;"
sudo service postgresql restart