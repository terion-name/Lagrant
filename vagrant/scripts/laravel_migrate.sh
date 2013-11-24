#!/usr/bin/env bash

PROJECT_PATH=$1

echo "--- Migrate the database for Laravel project ---"
cd ${PROJECT_PATH}
php /vagrant/artisan migrate --env=local

echo "--- Now lets run the db:seed command! ---"
php /vagrant/artisan db:seed --env=local