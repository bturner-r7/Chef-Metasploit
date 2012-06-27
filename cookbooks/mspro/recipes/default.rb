#
# Gets Metasploit commercial versions up and running
#   - does not manage keys
#   - does not manage licenses
#
# WARNING: in order to run this recipe, you must have a GitHub deploy 
# key for the Pro repo in the default['user'] user's .ssh dir.

execute "user check" do
  not_if do
    File.exist? "/home/#{node['msbuilder']}"
  end
  #log ("#{node['msbuilder']} user does not exist. Please create and populate with proper SSH key.") { level :fatal }
  # TODO This will indeed exit the recipe,
  # but with an exception. Find the real way to exit a recipe...
  command "exit 1"
end

# Be sure to add your private SSH key with access to GitHub repos to this user

# Bundler installs all Ruby-based library deps
gem_package "bundler"


# NOTE ON GIT RESOURCES: the "reference" variable is the branch that 
# is checked out as "deploy" on the node.  E.g. you will not see a 
# branch called "develop", you will see a branch called "deploy" with 
# content identical to develop.

# TODO Must accept RSA key fingerprint prompt
git "msf" do
  destination node["msf-root"]
  repository "git@github.com:rapid7/metasploit-framework.git"
  depth 1
  reference node['msf-git-branch']
  user node['user']
  group node['user']
  action :checkout
end

git "pro" do
  destination node["pro-root"]
  repository "git@github.com:rapid7/pro.git"
  depth 1
  reference node['pro-git-branch']
  user node['user']
  group node['user']
  action :checkout
end

link "#{node['pro-root']}/msf3" do
  to "#{node['msf-root']}"
end

template "#{node['rails-root']}/config/database.yml" do
  user node['user']
  source "database.yml.erb"
  owner node['user']
  mode "0644"
end

execute 'create postgres user' do
  user "postgres"
  command "createuser -SRd #{node['rails-database']['username']} > /dev/null 2>&1"
  ignore_failure true # only until we debug why above is thowing dumb error
end

execute 'set postgres user password' do
  user "postgres"
  command "psql -tc \"ALTER USER #{node['rails-database']['username']} WITH PASSWORD '#{node['rails-database']['password']}'\""
end

execute 'install bundle' do
  cwd node['rails-root']
  environment ( {'RAILS_ENV' => node['pro-env']} )
  command "bundle install"
end

# The Rails rake command itself is idempotent
execute 'create databases' do
  cwd node['rails-root']
  environment ( {'RAILS_ENV' => node['pro-env']} )
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

