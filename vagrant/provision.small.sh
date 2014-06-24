#!/usr/bin/env bash

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

${SCRIPTS}/phpmyadmin.sh $DATABASE_ROOT_PASSWORD

${SCRIPTS}/composer.sh

if [ -n "$DATABASE_NAME" ];
then
    ${SCRIPTS}/${DATABASE_TYPE}_createdb.sh $DATABASE_NAME $DATABASE_ROOT_PASSWORD
fi
