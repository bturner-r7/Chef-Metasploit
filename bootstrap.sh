#!/bin/bash
#
# bootstrap.sh 
#
# This script provides a basic environment for executing
# Chef cookbooks via the chef-solo command


# Get deps via apt
sudo apt-get update
sudo apt-get install -y build-essential curl libssl-dev libxml2 libxml2-dev libyaml-dev libxslt1-dev libreadline-dev libpq-dev git-core libzlib-ruby sqlite libsqlite3-dev libcurl3 libcurl3-gnutls libcurl4-openssl-dev

if [[ "$1" == "apt" ]]; then
  sudo apt-get install -y ruby1.9.1 ruby1.9.1-dev
else
  # Install Ruby
  sudo mkdir -p /usr/local/src && cd /usr/local/src
  sudo wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p194.tar.gz
  sudo tar -zxf ruby-1.9.3-p194.tar.gz
  cd ruby-1.9.3-p194
  sudo ./configure && sudo make && sudo make install

  # Install RubyGems
  cd /usr/local/src
  sudo wget http://rubyforge.org/frs/download.php/76073/rubygems-1.8.24.tgz
  sudo tar -xzf rubygems-1.8.24.tgz
  cd rubygems-1.8.24 && sudo ruby setup.rb
fi

# Install Chef gem
cd ~ # might as well go home at this point

# Until we upgrade to chef 11, we need to manually install
# net-ssh dependencies or we get into dependency hell
# TODO: Remove these lines when upgrading to chef 11
sudo gem install net-ssh-gateway --no-rdoc --no-ri --version 1.1.0
sudo gem install net-ssh-multi --no-rdoc --no-ri --ignore-dependencies --version 1.1
sudo gem install net-ssh --no-rdoc --no-ri --ignore-dependencies --version "~> 2.2.2"

# get older Chef until all 11.0 upgrade issues fixed -- 2013-02-05
sudo gem install chef --no-rdoc --no-ri --conservative --version "< 11"

# TODO: Remove after installing chef 11
sudo gem uninstall net-ssh-gateway --ignore-dependencies --version ">= 1.1.1"
sudo gem uninstall net-ssh --ignore-dependencies --version ">= 2.3"
