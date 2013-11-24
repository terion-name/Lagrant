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

SCRIPTS=/vagrant/vagrant/scripts

DATABASE_TYPE=$1
DATABASE_ROOT_PASSWORD=$2
DATABASE_NAME=$3

echo "--- Setting up system ---"

${SCRIPTS}/init.sh

${SCRIPTS}/php.sh

# web server MUST be installed immediately after PHP
${SCRIPTS}/nginx.sh

${SCRIPTS}/documentroot.sh

${SCRIPTS}/${DATABASE_TYPE}.sh $DATABASE_ROOT_PASSWORD

${SCRIPTS}/redis.sh

${SCRIPTS}/mongodb.sh

${SCRIPTS}/nodejs.sh

${SCRIPTS}/gmagick.sh

${SCRIPTS}/xdebug.sh

${SCRIPTS}/phpunit.sh

${SCRIPTS}/composer.sh

if [ $DATABASE_NAME != "_null" ];
then
    ${SCRIPTS}/mysql_create.sh $DATABASE_NAME $DATABASE_ROOT_PASSWORD
fi

# We assume that if there is no composer.json it is raw new project
# Otherwise project already exists and we need to migrate it

if [ ! -a "/vagrant/composer.json" ];
then
    ${SCRIPTS}/laravel_create.sh
    ${SCRIPTS}/laravel_dev_packages.sh
else
    ${SCRIPTS}/laravel_migrate.sh
fi