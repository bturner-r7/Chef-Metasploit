
cookbook_file "#{node['apache']['dir']}/conf.d/webdav.conf" do
  mode 0644
  source "webdav.conf"
  notifies :restart, resources(:service => "apache2")
end

directory "/var/www/http_put_php" do
  mode 0770
  owner node['apache']['user']
  group node['apache']['group']
end
