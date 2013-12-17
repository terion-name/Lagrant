#!/usr/bin/env bash

PROJECT_PATH=$1
ENV_NAME=$2

echo "--- Add Laravel dev packcages ---"

################################
# update composer.json
################################

cd ${PROJECT_PATH}

# while package-installer is not compatible with L4.1, comment it
# composer require --no-update rtablada/package-installer:dev-master

composer require --no-update barryvdh/laravel-debugbar:1.*
composer require --dev --no-update way/generators:dev-master way/laravel-test-helpers:dev-master barryvdh/laravel-ide-helper:1.*
composer require --dev --no-update fzaninotto/faker:dev-master codeception/codeception:* phpunit/phpunit=3.7.*
composer update --prefer-source

# adding recommended action for laravel-debugbar
COMPOSER_REPLACE_ANCHOR="\"post-update-cmd\": ["
COMPOSER_REPLACE_STR=$COMPOSER_REPLACE_ANCHOR"\n\n            \"php artisan debugbar:publish\","
sed -i "s/$COMPOSER_REPLACE_ANCHOR/$COMPOSER_REPLACE_STR/" composer.json


################################
# update configs
################################

# this will update main config and add package installer provider

cd ${PROJECT_PATH}/app/config

################################
# setting serviceProviders
################################

REPLACE_ANCHOR="'Illuminate\\\Workbench\\\WorkbenchServiceProvider',"

# while package-installer is not compatible with L4.1, comment it
# REPLACE_STR=$REPLACE_ANCHOR"\n\n        'Barryvdh\\\Debugbar\\\ServiceProvider',\n\n        'Rtablada\\\PackageInstaller\\\PackageInstallerServiceProvider',"

REPLACE_STR=$REPLACE_ANCHOR"\n\n        'Barryvdh\\\Debugbar\\\ServiceProvider',"
sed -i "s/$REPLACE_ANCHOR/$REPLACE_STR/" app.php

################################
# setting aliases
################################

REPLACE_ANCHOR_2="'View'            => 'Illuminate\\\Support\\\Facades\\\View',"
REPLACE_STR_2=$REPLACE_ANCHOR_2"\n\n        'Debugbar'            => 'Barryvdh\\\Debugbar\\\Facade',"
sed -i "s/$REPLACE_ANCHOR_2/$REPLACE_STR_2/" app.php

################################
# create a start file for development environment
################################

cd ${PROJECT_PATH}/app/start
echo -e '<?php\n' > ${ENV_NAME}.php

################################
# register providers via start file (see https://github.com/laravel/framework/issues/1603#issuecomment-21864164)
################################

echo "App::register('Way\\Generators\\GeneratorsServiceProvider');" >> ${ENV_NAME}.php
echo "App::register('Barryvdh\\LaravelIdeHelper\\IdeHelperServiceProvider');" >> ${ENV_NAME}.php

echo -e '\n' >> ${ENV_NAME}.php

################################
# register aliases
################################
# not need now, but left as a snippet
# echo "\$loader = \\Illuminate\\Foundation\\AliasLoader::getInstance();" >> ${ENV_NAME}.php
# echo "\$loader->alias('Profiler', 'Profiler\\Facades\\Profiler');" >> ${ENV_NAME}.php

################################
# publish packages configs
################################

cd ${PROJECT_PATH}

# php artisan config:publish loic-sharma/profiler
php artisan debugbar:publish
php artisan config:publish barryvdh/laravel-ide-helper --env="${ENV_NAME}"
php artisan config:publish barryvdh/laravel-debugbar

################################
# set up environment detection
################################

cd ${PROJECT_PATH}/bootstrap
sed -i "s/'your-machine-name'/'${ENV_NAME}'/" ./start.php
if [ $ENV_NAME != 'local' ]; then
    sed -i "s/'local'/'${ENV_NAME}'/" ./start.php
fi

################################
# generate IDE helper
################################

cd ${PROJECT_PATH}
php artisan clear-compiled --env="${ENV_NAME}"
php artisan ide-helper:generate --env="${ENV_NAME}"
php artisan optimize --env="${ENV_NAME}"
