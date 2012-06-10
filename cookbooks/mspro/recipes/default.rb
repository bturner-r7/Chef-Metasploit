#
# Gets Metasploit commercial versions up and running
#   - does not manage keys
#   - does not manage licenses
#
# WARNING: in order to run this recipe, you must have a GitHub deploy 
# key for the Pro repo in the root user's .ssh dir.


# Bundler installs all Ruby-based library deps
gem_package "bundler"


execute 'clone MSF' do
  command "git clone --depth 1 git@github.com:rapid7/metasploit-framework.git #{node['msf-root']}"
  user node['user']
  not_if {File.exists? "#{node['msf-root']}"}
end

execute 'clone Pro' do
  command "git clone --depth 1 git@github.com:rapid7/pro.git #{node['pro-root']}"
  user node['user']
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

# Generate and place database.yml
template "#{node['rails-root']}/config/database.yml" do
  source "database.yml.erb"
  owner node['user']
  mode "0644"
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


#---------- prosvc ------------------------------------------
# Generate and place start/stop init.d script for prosvc
template "/etc/init.d/prosvc" do
  source "prosvc_service.sh.erb"
  owner "root"
  mode "0744"
end

# Declare prosvc as a service
service "prosvc" do
  supports [:start, :stop, :restart]
  action :enable
end

service "prosvc" do
  action :restart
end

