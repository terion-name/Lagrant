#!/usr/bin/env bash

echo "--- Installing Ruby ---"

\curl -sSL https://get.rvm.io | bash -s stable

source /usr/local/rvm/scripts/rvm

source /etc/profile.d/rvm.sh

rvm requirements
rvm install ruby
rvm use ruby --default
rvm rubygems current
gem install -f rake
