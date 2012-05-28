#!/bin/bash
#
# bootstrap.sh 
#
# Bootstrapping script for boxes managed by Chef solo runs

# Get basics via apt

echo "#-------- Getting dependency packages...\n\n"
sudo apt-get update
sudo apt-get install -y build-essential curl libssl-dev libxml2-dev libxslt-dev libreadline5 libpq-dev git-core


echo "#-------- Installing Ruby...\n\n"
sudo mkdir /usr/local/src && cd /usr/local/src
wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p194.tar.gz
tar -zxf ruby-1.9.3-p194.tar.gz
cd ruby-1.9.3-p194
./configure && make && sudo make install


echo "#-------- Installing RubyGems...\n\n"
wget http://rubyforge.org/frs/download.php/76073/rubygems-1.8.24.tgz
cd rubygems-1.8.24 && sudo ruby setup.rb

echo "Installed `ruby --version`"
echo "Installed `gem --version`"
