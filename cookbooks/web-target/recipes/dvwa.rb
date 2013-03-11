
# Dependencies
package 'wget'
package 'subversion'
include_recipe 'web-target::apache2'
include_recipe "web-target::mysql"

subversion "/var/www/dvwa" do
  repository node['web-target']['dvwa']['svn_repo']
  revision node['web-target']['dvwa']['svn_rev']
  action :sync
end

template "/var/www/dvwa/config/config.inc.php" do
  source "dvwa-config.php.erb"
end

# Reload apache configuration before setting up dvwa.
# Chef postpones service reloads until the end of the run, but
# configuring DVWA depends on apache being configured correctly.
service "apache2" do
  action :reload
  not_if { FileTest.directory?("/var/lib/mysql/#{node['web-target']['dvwa']['db_name']}") }
end
execute "create-database" do
  command 'wget -q -o /dev/null --post-data="create_db=Create"  http://127.0.0.1/dvwa/setup.php'
  not_if { FileTest.directory?("/var/lib/mysql/#{node['web-target']['dvwa']['db_name']}") }
end
