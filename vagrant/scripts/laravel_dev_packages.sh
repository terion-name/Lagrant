#!/usr/bin/env bash

PROJECT_PATH=$1

echo "--- Add Laravel dev packcages ---"
cd ${PROJECT_PATH}
composer require --dev way/generators:dev-master loic-sharma/profiler:1.1.* fzaninotto/faker:dev-master

# TODO: update config