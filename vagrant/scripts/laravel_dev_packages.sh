#!/usr/bin/env bash

PROJECT_PATH=$1
ENV_NAME=$2

echo "--- Add Laravel dev packcages ---"

# update composer.json

cd ${PROJECT_PATH}
composer require --dev --no-update loic-sharma/profiler:1.1.* way/generators:dev-master way/laravel-test-helpers:dev-master barryvdh/laravel-ide-helper:1.*
composer require --dev --no-update fzaninotto/faker:dev-master codeception/codeception:* phpunit/phpunit=3.7.*
composer update

# update configs

cd ${PROJECT_PATH}/app/config/${ENV_NAME}

PROVIDERS="'Way\\\Generators\\\GeneratorsServiceProvider', 'Profiler\\\ProfilerServiceProvider', 'Barryvdh\\\LaravelIdeHelper\\\IdeHelperServiceProvider'"
FACADES="'Profiler' => 'Profiler\\\Facades\\\Profiler'"

sed -i "s/{{PROVIDERS_ARRAY}}/$PROVIDERS/" ./app.php
sed -i "s/{{ALIASES_ARRAY}}/$FACADES/" ./app.php

# publish packages configs

cd ${PROJECT_PATH}

php artisan config:publish loic-sharma/profiler --env="${ENV_NAME}"
php artisan config:publish barryvdh/laravel-ide-helper --env="${ENV_NAME}"

# generate IDE helper

php artisan clear-compiled --env="${ENV_NAME}"
php artisan ide-helper:generate --env="${ENV_NAME}"
php artisan optimize --env="${ENV_NAME}"