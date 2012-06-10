#
# Gets Metasploit commercial versions up and running
#   - does not manage keys
#   - does not manage licenses


# Bundler installs all Ruby-based library deps
gem_package "bundler"

template "#{node['rails-root']}/config/database.yml" do
  source "database.yml.erb"
  owner node['user']
  mode "0644"
end

execute 'clone MSF' do
  command "git clone --depth 1 git@github.com:rapid7/metasploit-framework.git #{node['msf-root']}"
  not_if {File.exists? "#{node['msf-root']}"}
end

execute 'clone Pro' do
  command "git clone --depth 1 git@github.com:rapid7/pro.git #{node['pro-root']}"
  not_if {File.exists? "#{node['pro-root']}"}
end

execute 'update MSF code' do
  cwd node['msf-root']
  command "git pull"
end

execute 'update Pro code' do
  cwd node['pro-root']
  command "git pull"
end

execute 'switch to develop branch on Pro' do
  cwd node['pro-root']
  command "git checkout develop"
end

link "#{node['pro-root']}/msf3" do
  to "#{node['msf-root']}"
end

# Match database.yml
execute 'create postgres user' do
  user "postgres"
  command "createuser -SRd #{node['rails-database']['username']} > /dev/null 2>&1"
  ignore_failure true # only until we debug why above is thowing dumb error
end

# Match database.yml -- this command is idempotent
execute 'set postgres user password' do
  user "postgres"
  command "psql -tc \"ALTER USER #{node['rails-database']['username']} WITH PASSWORD '#{node['rails-database']['password']}'\""
end


execute 'install bundle' do
  cwd node['rails-root']
  environment ( {'RAILS_ENV' => 'development'} )
  command "bundle install"
end

# The Rails rake command itself is idempotent
execute 'create databases' do
  cwd node['rails-root']
  environment ( {'RAILS_ENV' => 'development'} )
  command "rake db:create:all"
end

#execute 'stop prosvc' do
  #cwd "#{node['pro-root']}/engine/tmp"
  #user "root"
  #command "kill -9 `cat prosvc.pid` && rm prosvc.pid"
  #not_if{!(File.exists? "#{node['pro-root']}/engine/tmp/prosvc.pid")} # don't do it if no PID
  #ignore_failure true
#end

#execute 'start prosvc' do
  #cwd "#{node['pro-root']}/engine/scripts"
  #user "root"
  #environment ( {'RAILS_ENV' => 'test', 'PROSVC_ENV' => node['prosvc']['env']} )
  #command "./ctl.sh start"
  #only_if{!(File.exists? "#{node['pro-root']}/engine/tmp/prosvc.pid")} # only do it if no PID
#end


# start the Rails server process
