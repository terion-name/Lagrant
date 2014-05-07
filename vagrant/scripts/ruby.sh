#!/usr/bin/env bash

echo "--- Installing Ruby ---"

sudo \curl -sSL https://get.rvm.io | bash -s stable

source /usr/local/rvm/scripts/rvm

source /etc/profile.d/rvm.sh

sudo rvm requirements
sudo rvm install ruby
rvm use ruby --default
rvm rubygems current
sudo gem install -f rake
