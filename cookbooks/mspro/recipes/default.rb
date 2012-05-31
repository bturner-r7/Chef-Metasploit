# Ensure bundler is available and you're mostly good to go
gem_package "bundler"

execute 'clone code' do
  command "git clone -depth 1 git@github.com:rapid7/Pro.git #{node['pro-root']}"
  not_if {File.exists? "#{node['pro-root']}"}
end

execute 'update code' do
  cwd node['pro-root']
  command "git pull"
end

# Start prosvc w/ known pid from node attrs

execute 'install bundle' do
  cwd "#{node['pro-root']}/ui"
  environment ( {'RAILS_ENV' => 'development'} )
  command "bundle install"
end

# - set up path to the Rails.root in node data
# Ensure key file is available -- fail otherwise
#
# Pull code from GitHub
#
# bundle install
#
# create database w/ rake
#
# load database w/ rake
#
# start the server process
