#Lagrant

Boilerplate Laravel Vagrant config with autosetup.

**Makes an isolated local development featured environment and installs Laravel with dev-packages OR runs exisisting one.**
```
Status: Stable
```
##Requirements
* [Vagrant](http://www.vagrantup.com/)
* [Virtual Box](https://www.virtualbox.org/)

##Usage
###Basic usage
Open terminal, go to desired directory and type in:
```bash
git clone https://github.com/yaapis/Lagrant && mv Lagrant/* ./ && rm -r -f Lagrant
mv vagrant/provision.[small|medium|full].sh vagrant/provision.sh
vagrant up
```
Or just clone/download Lagrant, edit Vagrantfile's variables and/or provision.sh to your prefers and run ```vagrant up```

And go have some coffee.
When the script will finish its work open [http://localhost:8080](http://localhost:8080) or http://10.10.10.10 and you'll see Laravel welcome page.
Enjoy!

**This will also work with existing project!**
If you run Lagrant from an existing project repo it will setup the VM and migrate&seed database to provide you an isolated local development environment.

###Advanced usage
If you're not happy with my defaults, fork the repo, edit variables in the beginning of Vagrantfile, edit provision.sh script by changing set of existing modules and/or write your own and use it :)

###Using VM resources
To use shipped resources (such as composer, phpunit, etc) open terminal in project directory and type ```vagrant ssh```. Then ```cd /vagrant``` and you are in project root in the VM. Files are seamlessly synced, so all your changes in VM will immediatly appear in host filesystem.

To connect to your databases (mysql, mongo, etc) in VM via clients use connection over SSH tunnel. SSH host will be 10.10.10.10, user and password — vagrant. Like this:

![mongohub](https://photos-2.dropbox.com/t/0/AADXf8_TGzKgs7bI2_RHhvbGtIQUK03myJBlgwd6MxAQxw/12/10936637/png/2048x1536/3/1398765600/0/2/%D0%A1%D0%BA%D1%80%D0%B8%D0%BD%D1%88%D0%BE%D1%82%202014-04-29%2011.28.47.png/S4VfLd1xll8Z_TuN-sm9tAxGq0pW6Tx2FgMAvxvk4QE)

##What's in the box
####To remove features that you don't need simply comment out or remove corresponding lines in `vagrant/provision.sh`
Lagrant will load Ubuntu 12 x64 VM with following components:
* [php 5.5](http://php.net)
* [nginx](http://nginx.org/) as a default web-server
* chosen database ([mysql](http://www.mysql.com/), [mariadb](https://mariadb.org/), [postgresql](http://www.postgresql.org/); currently only mysql supported)
* [redis](http://redis.io/)
* [mongodb](http://www.mongodb.org/)
* [nodejs](http://nodejs.org/) and [npm](https://npmjs.org/)
* [bower](http://bower.io/)
* [grunt](http://gruntjs.com/)
* [grunt-autoprefixer](https://github.com/nDmitry/grunt-autoprefixer)
* [gulp](http://gulpjs.com/)
* [gulp-autoprefixer](https://npmjs.org/package/gulp-autoprefixer)
* [phantomjs](http://phantomjs.org/)
* [ruby](https://www.ruby-lang.org) with [rake](http://rake.rubyforge.org/)
* [less](http://lesscss.org/)
* [sass](http://sass-lang.com/) with [compass](http://compass-style.org/)
* [coffeescript](http://coffeescript.org/)
* [DART](https://www.dartlang.org)
* [imagick](http://php.net/imagick) or [gmagick](http://www.php.net/manual/en/book.gmagick.php) (imagick by default)
* [ffmpeg](http://www.ffmpeg.org/) **commented by default!**
* [xdebug](http://xdebug.org/)
* [phpunit](http://phpunit.de/)
* [composer](http://getcomposer.org/)
* [beanstalkd queue server](https://github.com/kr/beanstalkd) and [beanstalk console](https://github.com/ptrofimov/beanstalk_console), available after install at [http://localhost:8080/beanstalkd/index.php](http://localhost:8080/beanstalkd/index.php)
* [phpmyadmin](http://www.phpmyadmin.net), available after install at http://33.33.33.33/phpmyadmin/
 
Also it will create a database with provided in Vagrantfile credentials (default root password is *root*, default db name is *database*).
If it performs a clean install of Laravel, it will create an environment configs set (defaults to *dev*) and set up local database and app configs.

Development packages (will be added during fresh install) included at the moment:
* [way/generators](https://github.com/JeffreyWay/Laravel-4-Generators) — awesome code generators for rapid development
* [way/laravel-test-helpers](https://github.com/JeffreyWay/Laravel-Test-Helpers) — helpers for Unit Testing
* [barryvdh/laravel-ide-helper](https://github.com/barryvdh/laravel-ide-helper) — IDE helper generator
* [fzaninotto/faker](https://github.com/fzaninotto/Faker) — perfect tool for faking data and seeding test/dev databases
* [codeception/codeception](https://github.com/Codeception/Codeception) — great BDD-testing tool

Other packages (added to require section of composer and to configs):
* [barryvdh/laravel-debugbar](https://github.com/barryvdh/laravel-debugbar) — awesome debug panel
* [Anahkiasen/former](https://github.com/Anahkiasen/former) — very useful form generator tool
* [Anahkiasen/rocketeer](https://github.com/Anahkiasen/rocketeer) — incredible deployment tool
* ~~[rtablada/package-installer](https://github.com/rtablada/package-installer) — handy tool for quick and easy installation of supported Laravel 4 packages~~ (is not compatible with Laravel 4.1, commented out till fix)
* [pda/pheanstalk](https://github.com/pda/pheanstalk/) for beanstalkd L4 core support
 
##Troubleshoting

If establishing of private network during VM booting fails, run (for Mac users):
```
sudo /Library/StartupItems/VirtualBox/VirtualBox restart
```
(see [this Vagrant/Virtual Box issue](https://github.com/mitchellh/vagrant/issues/2392#issuecomment-27367698) for details)

If you faced any error — feel free to open [an issue](https://github.com/terion-name/Lagrant/issues)

##Roadmap

###Server
* xhprof
* mariadb
* phpMyAdmin
* postgresql
* phpPgAdmin

###Application
* basic bower config
* basic gulp config
* build scripts (artisan commands)
* and bunch of cool Laravel Packages (research in progress)
 
##Thanx
Thanx to [Jeffrey Way](https://github.com/JeffreyWay) for inspiring and ofcourse to [Taylor Otwell](https://github.com/taylorotwell) for such awesome and stunning framework
