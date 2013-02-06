
package 'php5-mysql'

include_recipe "apache2"
include_recipe "apache2::mod_dav_fs"
include_recipe "apache2::mod_php5"

file "/var/www/index.html" do
  action :delete
end
