msbuilder_created = File.exists? "/home/#{node['user']}"

if msbuilder_created
  include_recipe "mspro::conditional-mspro"
else
  Chef::Log.info "/home/#{node['user']} does not exist. Create this user and add a GitHub-enabled private key to continue with dev setup."
end
