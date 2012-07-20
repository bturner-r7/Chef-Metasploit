msbuilder_ready = false

execute "add user" do
  not_if do
    File.exist? "/home/#{node['user']}"
  end
  user "root"
  command "useradd -m #{node['user']} && usermod -aG sudo #{node['user']} && echo \"#{node['password']}:#{node['user']}\" | chpasswd"
end

execute "SSH key check for #{node['user']}" do
  not_if do
    File.exist? "/home/#{node['user']}/.ssh/id_rsa"
  end
  user "root"
  msbuilder_ready = false
end


if msbuilder_ready
  include_recipe "mspro::conditional-mspro"
else
  Chef::Log.fatal "/home/#{node['user']} does not have GitHub-enabled private SSH key in place, please add."
end
