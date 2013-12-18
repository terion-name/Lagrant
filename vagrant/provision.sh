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
PROJECT_PATH=/vagrant

ENV_NAME=$1
DATABASE_TYPE=$2
DATABASE_ROOT_PASSWORD=$3
DATABASE_NAME=$4

echo "--- Setting up system ---"

${SCRIPTS}/init.sh $ENV_NAME

${SCRIPTS}/php.sh

# web server MUST be installed immediately after PHP
${SCRIPTS}/nginx.sh

${SCRIPTS}/documentroot.sh

${SCRIPTS}/${DATABASE_TYPE}.sh $DATABASE_ROOT_PASSWORD

${SCRIPTS}/redis.sh

${SCRIPTS}/mongodb.sh

${SCRIPTS}/nodejs.sh

${SCRIPTS}/bower.sh

${SCRIPTS}/grunt.sh

${SCRIPTS}/less.sh

${SCRIPTS}/coffeescript.sh

${SCRIPTS}/imagick.sh

${SCRIPTS}/xdebug.sh

${SCRIPTS}/phpunit.sh

${SCRIPTS}/composer.sh

if [ -n "$DATABASE_NAME" ];
then
    ${SCRIPTS}/${DATABASE_TYPE}_createdb.sh $DATABASE_NAME $DATABASE_ROOT_PASSWORD
fi

# We assume that if there is no composer.json it is raw new project
# Otherwise project already exists and we need to migrate it

if [ ! -a "/vagrant/composer.json" ];
then
    ${SCRIPTS}/laravel_create.sh $PROJECT_PATH $ENV_NAME
    if [ -n "$DATABASE_NAME" ];
    then
        ${SCRIPTS}/laravel_set_db.sh $PROJECT_PATH $ENV_NAME $DATABASE_TYPE $DATABASE_NAME $DATABASE_ROOT_PASSWORD
    fi
    ${SCRIPTS}/laravel_packages.sh $PROJECT_PATH $ENV_NAME
else
    ${SCRIPTS}/laravel_migrate.sh $PROJECT_PATH $ENV_NAME
fi