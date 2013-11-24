#!/usr/bin/env bash

PROJECT_PATH=$1

echo "--- Add Laravel dev packcages ---"
composer require way/generators:dev-master --dev
composer require loic-sharma/profiler:1.1.* --dev
composer require fzaninotto/faker:dev-master --dev