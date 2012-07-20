msbuilder_created = File.exists? "/home/#{node['user']}"

if msbuilder_created
  include_recipe "mspro::conditional-mspro"
else
  Chef::Log.fatal "/home/#{node['user']} does not exist. Please add with a GitHub-enabled ssh key to continue."
end
