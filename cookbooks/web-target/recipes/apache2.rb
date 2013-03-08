
package 'php5-mysql'

include_recipe "apache2"
include_recipe "apache2::mod_dav_fs"
include_recipe "apache2::mod_php5"
include_recipe "apache2::mod_ssl"

# HACK to override the template in apache2::mod_ssl
begin
  t = resources(:template => "#{node['apache']['dir']}/mods-available/ssl.conf")
  t.source "apache2-ssl.conf.erb"
  t.cookbook "web-target"
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.warn "could not find template mods/ssl.conf.erb to modify"
end

apache_site "default"
apache_site "default-ssl"

file "/var/www/index.html" do
  action :delete
end
