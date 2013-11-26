#Lagrant

Boilerplate Laravel Vagrant config with autosetup.

**Makes an isolated local development featured environment and installs Laravel with dev-packages OR runs exisisting one.**
```
Status: In development. Minimum pack ready. Addons to go
```
##Requirements
* [Vagrant](http://www.vagrantup.com/)
* [Virtual Box](https://www.virtualbox.org/)

##Usage
###Basic usage
Open terminal, go to desired directory and type in:
```bash
git clone https://github.com/terion-name/Lagrant && mv Lagrant/* ./ && rm -r -f Lagrant && vagrant up
```
Or just clone/download, edit Vagrantfile's variables and run ```vagrant up```

And go have some coffee.
When the script will finish it's work open [http://localhost:8080](http://localhost:8080) or http://33.33.33.33 and you'll see Laravel welcome page.
Enjoy!

**This will also work with existing project!**
If you run Lagrant from an existing project repo it will setup the VM and migrate&seed database to provide you an isolated local development environment.

###Advanced usage
If you're not happy with my defaults, fork the repo, edit variables in the beginning of Vagrantfile, edit provision.sh script by changing set of existing modules and/or write your own and use it :)

##What's in the box
Lagrant will load Ubuntu 12 x64 VM with following components:
* php 5.5
* nginx as a default web-server
* chosen database (mysql, mariadb, postgresql; currently only mysql supported)
* redis
* mongodb
* nodejs and npm
* gmagick or imagick (gmagick by default, it is quite faster)
* xdebug
* phpunit
* composer
 
Also it will create a database with provided in Vagrantfile credentials (default root password is *root*, default db name is *database*).
If it performs a clean install of Laravel, it will create an environment configs set (defaults to *dev*) and set up local database and app configs.

Development packages (will be added during fresh install) included at the moment:
* [way/generators](https://github.com/JeffreyWay/Laravel-4-Generators) — awesome code generators for rapid development
* [way/laravel-test-helpers](https://github.com/JeffreyWay/Laravel-Test-Helpers) — helpers for Unit Testing
* [barryvdh/laravel-ide-helper](https://github.com/barryvdh/laravel-ide-helper) — IDE helper generator
* [loic-sharma/profiler](https://github.com/loic-sharma/profiler) — profiler toolbar
* [fzaninotto/faker](https://github.com/fzaninotto/Faker) — perfect tool for faking data and seeding test/dev databases
* [codeception/codeception](https://github.com/Codeception/Codeception) — great BDD-testing tool

##Roadmap
* mariadb
* postgresql
* xhprof
* ruby
* bower
* grunt
* less
* YUI compressor
* coffeescript
* DART
* apache
* and bunch of cool Laravel Packages
