#!/usr/bin/env bash

PROJECT_PATH=$1
ENV_NAME=$2

echo "--- Add Laravel dev packcages ---"

################################
echp "update composer.json"
################################

cd ${PROJECT_PATH}

composer require --no-update rtablada/package-installer:dev-master
composer require --no-update barryvdh/laravel-debugbar:1.* pda/pheanstalk:dev-master anahkiasen/rocketeer:dev-master anahkiasen/former:dev-master
composer require --dev --no-update way/generators:dev-master way/laravel-test-helpers:dev-master barryvdh/laravel-ide-helper:1.*
composer require --dev --no-update fzaninotto/faker:dev-master codeception/codeception:* phpunit/phpunit=3.7.*

# adding recommended action for laravel-debugbar
COMPOSER_REPLACE_ANCHOR='"post-update-cmd": \['
COMPOSER_REPLACE_STR=$COMPOSER_REPLACE_ANCHOR"\n"'            "php artisan debugbar:publish",'
sed -i "s/$COMPOSER_REPLACE_ANCHOR/$COMPOSER_REPLACE_STR/" composer.json

################################
echo "update configs"
################################

# this will update main config and add package installer provider

cd ${PROJECT_PATH}/app/config

################################
echo "setting serviceProviders"
################################

REPLACE_ANCHOR="'Illuminate\\\Workbench\\\WorkbenchServiceProvider',"

REPLACE_STR=$REPLACE_ANCHOR"\n\n        'Barryvdh\\\Debugbar\\\ServiceProvider',\n\n        'Rtablada\\\PackageInstaller\\\PackageInstallerServiceProvider',\n\n        'Rocketeer\\\RocketeerServiceProvider',\n\n        'Former\\\FormerServiceProvider',"
sed -i "s/$REPLACE_ANCHOR/$REPLACE_STR/" app.php

################################
echo "setting aliases"
################################

REPLACE_ANCHOR_2="'View'            => 'Illuminate\\\Support\\\Facades\\\View',"
REPLACE_STR_2=$REPLACE_ANCHOR_2"\n\n        'Debugbar'            => 'Barryvdh\\\Debugbar\\\Facade',\n\n        'Rocketeer'            => 'Rocketeer\\\Facades\\\Rocketeer',\n\n        'Former'            => 'Former\\\Facades\\\Former',"
sed -i "s/$REPLACE_ANCHOR_2/$REPLACE_STR_2/" app.php

################################
echo "create a start file for development environment"
################################

cd ${PROJECT_PATH}/app/start
echo -e '<?php\n' > ${ENV_NAME}.php

################################
echo "register providers via start file (see https://github.com/laravel/framework/issues/1603#issuecomment-21864164)"
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
echo "set up environment detection"
################################

cd ${PROJECT_PATH}/bootstrap
sed -i "s/'your-machine-name'/'${ENV_NAME}'/" ./start.php
if [ $ENV_NAME != 'local' ]; then
    sed -i "s/'local'/'${ENV_NAME}'/" ./start.php
fi

################################
echo "install all this stuff"
################################

# synced folders are extremely slow
# and installation process on HDD disks simply hangs because of this
# so lets install deps out of synced folder to improve performance and then move them in place

cd ${PROJECT_PATH}
mkdir /tmp/laravel-install
cp composer.json /tmp/laravel-install/composer.json
cd /tmp/laravel-install
composer install --prefer-source --no-scripts
mv composer.lock ${PROJECT_PATH}/
cp -R -f vendor/ ${PROJECT_PATH}/
cd ${PROJECT_PATH}
rm -rf /tmp/laravel-install
composer dump-autoload
php artisan clear-compiled
php artisan optimize


################################
echo "publish packages configs"
################################

php artisan key:generate
php artisan debugbar:publish
php artisan config:publish barryvdh/laravel-ide-helper --env="${ENV_NAME}"
php artisan config:publish barryvdh/laravel-debugbar
php artisan config:publish anahkiasen/former

# ignite is interactive and needs manual setup
# php artisan deploy:ignite



################################
echo generate IDE helper
################################

cd ${PROJECT_PATH}
php artisan clear-compiled --env="${ENV_NAME}"
php artisan ide-helper:generate --env="${ENV_NAME}"
php artisan optimize --env="${ENV_NAME}"
