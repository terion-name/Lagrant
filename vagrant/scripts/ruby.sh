#!/usr/bin/env bash

echo "--- Installing Ruby with Rake and Bundler ---"

sudo apt-get -y update
sudo apt-get -y install curl git-core build-essential python-software-properties python g++ make
curl -sSL https://get.rvm.io | bash -s stable --ruby
source ~/.profile
source /usr/local/rvm/scripts/rvm
source /etc/profile.d/rvm.sh
rvm requirements
rvm install ruby
rvm use ruby --default
rvm rubygems current
gem install bundler
gem install -f rake