#!/usr/bin/env bash

# TODO!
# pass DB creation parameters... from where?
# mariadb
# postgresql
# xhprof
# ruby
# bower
# grunt
# less
# YUI compressor
# coffeescript
# DART
# apache

echo "--- Setting up system ---"

./scripts/init.sh

./scripts/mysql.sh $MYSQL_ROOT_PASSWORD

./scripts/redis.sh

./scripts/mongodb.sh

./scripts/nodejs.sh

./scripts/php.sh

./scripts/nginx.sh

./scripts/gmagick.sh

./scripts/xdebug.sh

./scripts/phpunit.sh

./scripts/composer.sh

./scripts/documentroot.sh

./scripts/nginxsetup.sh

./scripts/mysql_create.sh $DBNAME $MYSQL_ROOT_PASSWORD

# We assume that if there is no composer.json — it is raw new project
# Otherwise — project already exists and we need to migrate it

if [ ! -f /vagrant/composer.json ]; then
./scripts/laravel_create.sh
./scripts/laravel_dev_packages.sh
else
./scripts/laravel_migrate.sh
fi