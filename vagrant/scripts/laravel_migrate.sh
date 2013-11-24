#!/usr/bin/env bash

echo "--- Migrate the database for Laravel project ---"
php /vagrant/artisan migrate --env=local

echo "--- Now lets run the db:seed command! ---"
php /vagrant/artisan db:seed --env=local