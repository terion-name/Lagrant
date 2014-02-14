#!/usr/bin/env bash

echo "--- Installing Ruby ---"

sudo \curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm requirements
rvm install ruby
rvm use ruby --default
rvm rubygems current
sudo gem install rake