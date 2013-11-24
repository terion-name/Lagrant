#!/usr/bin/env bash

# TODO!
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

DATABASE_TYPE = $1
DATABASE_ROOT_PASSWORD = $2
DATABASE_NAME = $3

echo "--- Setting up system ---"

./scripts/init.sh

./scripts/php.sh

./scripts/${DATABASE_TYPE}.sh $DATABASE_ROOT_PASSWORD

./scripts/redis.sh

./scripts/mongodb.sh

./scripts/nodejs.sh

./scripts/nginx.sh

./scripts/gmagick.sh

./scripts/xdebug.sh

./scripts/phpunit.sh

./scripts/composer.sh

./scripts/documentroot.sh

./scripts/nginxsetup.sh

if [ $DATABASE_NAME != _null ]; then
./scripts/mysql_create.sh $DATABASE_NAME $DATABASE_ROOT_PASSWORD
fi

# We assume that if there is no composer.json — it is raw new project
# Otherwise — project already exists and we need to migrate it

if [ ! -f /vagrant/composer.json ]; then
./scripts/laravel_create.sh
./scripts/laravel_dev_packages.sh
else
./scripts/laravel_migrate.sh
fi