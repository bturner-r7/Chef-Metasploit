# Hacked-up version of the one provided by Opscode

#::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

include_recipe "postgresql::client"

case node[:postgresql][:version]
when "8.3"
  node.default[:postgresql][:ssl] = "off"
when "8.4"
  node.default[:postgresql][:ssl] = "true"
end

# Include the right "family" recipe for installing the server
# since they do things slightly differently.
case node.platform
when "redhat", "centos", "fedora", "suse", "scientific", "amazon"
  include_recipe "postgresql::server_redhat"
when "debian", "ubuntu"
  include_recipe "postgresql::server_debian"
end

template "#{node[:postgresql][:dir]}/pg_hba.conf" do
  source "pg_hba.conf.erb"
  owner "postgres"
  group "postgres"
  mode 0600
  notifies :reload, resources(:service => "postgresql"), :immediately
end

# Default PostgreSQL install has 'ident' checking on unix user 'postgres'
# and 'md5' password checking with connections from 'localhost'. This script
# runs as user 'postgres', so we can execute the 'role' and 'database' resources
# as 'root' later on, passing the below credentials in the PG client.
bash "assign-postgres-password" do
  user 'postgres'
  code <<-EOH
echo "ALTER ROLE postgres ENCRYPTED PASSWORD '#{node[:postgresql][:password][:postgres]}';" | psql
  EOH
  not_if do
    begin
      require 'rubygems'
      Gem.clear_paths
      require 'pg'
      conn = PGconn.connect("localhost", 5432, nil, nil, nil, "postgres", node['postgresql']['password']['postgres'])
    rescue PGError
      false
    end
  end
  action :run
end

node[:postgresql][:users].each do |user|
  pg_user user[:username] do
    privileges :superuser => user["superuser"], :createdb => user["createdb"], :login => user["login"]
    password user["password"]
  end
end
