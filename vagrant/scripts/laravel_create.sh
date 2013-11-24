#!/usr/bin/env bash

PROJECT_PATH=$1

echo "--- Create Laravel project ---"

mkdir ${PROJECT_PATH}/_tmp

composer create-project laravel/laravel ${PROJECT_PATH}/_tmp

cd ${PROJECT_PATH}
mv _tmp/* ${PROJECT_PATH}
rm _tmp