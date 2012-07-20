msbuilder_ready = false

execute "add user" do
  not_if do
    File.exist? "/home/#{node['user']}"
  end
  user "root"
  command "useradd -m #{node['user']} && usermod -aG sudo #{node['user']}"
end

execute "SSH key check for #{node['user']}" do
  not_if do
    File.exist? "/home/#{node['user']}/.ssh/id_rsa"
  end
  msbuilder_ready = false
end


if msbuilder_ready
  include_recipe "mspro::conditional-mspro"
else
  Chef::Log.fatal "/home/#{node['user']} does not exist. Create this user and add a GitHub-enabled private key to continue with dev setup."
end
