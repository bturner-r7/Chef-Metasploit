#!/bin/bash
#
# bootstrap.sh 
#
# Bootstrapping script for boxes managed by Chef solo runs


# Get deps via apt
sudo apt-get update
sudo apt-get install -y build-essential curl libssl-dev libxml2-dev libyaml-dev libxslt-dev libreadline-dev libpq-dev git-core libzlib-ruby


# Install Ruby
sudo mkdir -p /usr/local/src && cd /usr/local/src
wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p194.tar.gz
tar -zxf ruby-1.9.3-p194.tar.gz
cd ruby-1.9.3-p194
./configure --prefix=/usr && make && sudo make install

# Install RubyGems
wget http://rubyforge.org/frs/download.php/76073/rubygems-1.8.24.tgz
cd rubygems-1.8.24 && sudo ruby setup.rb

# Install Chef gem
sudo gem install chef --no-rdoc --no-ri

echo "Installed `ruby --version`"
echo "Installed `gem --version`"
