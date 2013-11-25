#!/usr/bin/env bash

PROJECT_PATH=$1
ENV_NAME=$2

echo "--- Migrate the database for Laravel project ---"
cd ${PROJECT_PATH}
php /vagrant/artisan migrate --env=${ENV_NAME}

echo "--- Now lets run the db:seed command! ---"
php /vagrant/artisan db:seed --env=${ENV_NAME}