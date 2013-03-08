
package 'php5-mysql'

include_recipe "apache2"
include_recipe "apache2::mod_dav_fs"
include_recipe "apache2::mod_php5"

apache_site "default"
apache_site "default-ssl"

file "/var/www/index.html" do
  action :delete
end
