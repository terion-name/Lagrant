#!/usr/bin/env bash

echo -n "--- Migrate the database for Laravel project ---"
php /vagrant/artisan migrate --env=local

echo -n "--- Now lets run the db:seed command! ---"
php /vagrant/artisan db:seed --env=local