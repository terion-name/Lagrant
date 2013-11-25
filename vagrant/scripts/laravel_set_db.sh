#!/usr/bin/env bash

PROJECT_PATH=$1
ENV_NAME=$2
DATABASE_TYPE=$3
DATABASE_NAME=$4
DATABASE_ROOT_PASSWORD=$5

if [ $DATABASE_TYPE = "mariadb" ];
then
    DATABASE_TYPE=mysql
fi

echo "--- Set up database in Laravel ---"

cd ${PROJECT_PATH}/app/config/${ENV_NAME}
cp ${PROJECT_PATH}/vagrant/templates/laravel_config_database.php ./database.php

sed -i "s/{{DB_TYPE}}/$DATABASE_TYPE/g" ./database.php
sed -i "s/{{DB_NAME}}/$DATABASE_NAME/" ./database.php
sed -i "s/{{DB_PASSWORD}}/$DATABASE_ROOT_PASSWORD/" ./database.php