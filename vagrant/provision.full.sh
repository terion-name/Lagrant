#!/usr/bin/env bash

SCRIPTS=/vagrant/vagrant/scripts
PROJECT_PATH=/vagrant

ENV_NAME=$1
DATABASE_TYPE=$2
DATABASE_ROOT_PASSWORD=$3
DATABASE_NAME=$4

echo "--- Setting up system ---"

${SCRIPTS}/init.sh $ENV_NAME

${SCRIPTS}/php.sh

# web server MUST be installed immediately after PHP
${SCRIPTS}/nginx.sh

${SCRIPTS}/documentroot.sh

${SCRIPTS}/memcached.sh

${SCRIPTS}/ruby.sh

${SCRIPTS}/${DATABASE_TYPE}.sh $DATABASE_ROOT_PASSWORD

${SCRIPTS}/phpmyadmin.sh $DATABASE_ROOT_PASSWORD

${SCRIPTS}/sqlite.sh

${SCRIPTS}/redis.sh

${SCRIPTS}/mongodb.sh

${SCRIPTS}/nodejs.sh

${SCRIPTS}/bower.sh

${SCRIPTS}/grunt.sh
${SCRIPTS}/grunt-autoprefixer.sh

${SCRIPTS}/gulp.sh
${SCRIPTS}/gulp-autoprefixer.sh

${SCRIPTS}/phantomjs.sh

${SCRIPTS}/less.sh

${SCRIPTS}/sass.sh

${SCRIPTS}/coffeescript.sh

${SCRIPTS}/dart.sh

${SCRIPTS}/imagick.sh

# FFMpeg needs to be compiled, it takes a lot of time
# So uncomment ffmpeg installer if you really need it
# ${SCRIPTS}/ffmpeg.sh

${SCRIPTS}/xdebug.sh

${SCRIPTS}/phpunit.sh

${SCRIPTS}/composer.sh

${SCRIPTS}/beanstalkd.sh

${SCRIPTS}/supervisor.sh

if [ -n "$DATABASE_NAME" ];
then
    ${SCRIPTS}/${DATABASE_TYPE}_createdb.sh $DATABASE_NAME $DATABASE_ROOT_PASSWORD
fi

# We assume that if there is no composer.json it is raw new project
# Otherwise project already exists and we need to migrate it

if [ ! -a "/vagrant/composer.json" ];
then
    ${SCRIPTS}/laravel_create.sh $PROJECT_PATH $ENV_NAME
    if [ -n "$DATABASE_NAME" ];
    then
        ${SCRIPTS}/laravel_set_db.sh $PROJECT_PATH $ENV_NAME $DATABASE_TYPE $DATABASE_NAME $DATABASE_ROOT_PASSWORD
    fi
    ${SCRIPTS}/laravel_setup.sh $PROJECT_PATH $ENV_NAME
else
    ${SCRIPTS}/laravel_migrate.sh $PROJECT_PATH $ENV_NAME
fi
