#!/usr/bin/env bash

PROJECT_PATH=$1

echo "--- Create Laravel project ---"

# mkdir ${PROJECT_PATH}/_tmp
# composer create-project laravel/laravel ${PROJECT_PATH}/_tmp
# cd ${PROJECT_PATH}
# cp -r _tmp/* ${PROJECT_PATH}
# rm -r -f _tmp

cd ${PROJECT_PATH}
wget https://github.com/laravel/laravel/archive/master.zip
unzip -o master.zip && rm master.zip
composer install
php artisan key:generate

# TODO: add local env
# TODO: update db config if db was created