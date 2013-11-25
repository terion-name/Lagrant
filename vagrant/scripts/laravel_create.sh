#!/usr/bin/env bash

PROJECT_PATH=$1
ENV_NAME=$2

echo "--- Create Laravel project ---"

cd ${PROJECT_PATH}
wget https://github.com/laravel/laravel/archive/master.zip
unzip -o master.zip && rm master.zip
cp -r laravel-master/* ./
rm -r -f laravel-master
composer install
php artisan key:generate
mkdir ${PROJECT_PATH}/app/config/${ENV_NAME}

# TODO: add local env
# TODO: update db config if db was created