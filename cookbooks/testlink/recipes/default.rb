# Sets up Testlink 1.9
# 
# Homepage: http://www.teamst.org/
# Installation guide: http://www.teamst.org/_tldoc/1.8/installation_manual.pdf
# -----------------------------

# Needed for random passwords
include_recipe "openssl::default"

# Needed for aa-complain
package "apparmor-utils" do
  action :install
end
# Stop for now to get MySQL installed
# Also teardown profiles
# Using execute since Chef service doesn't define teardown
execute "apparmor change mysql to complain" do
  command "sudo /etc/init.d/apparmor stop"
  command "sudo /etc/init.d/apparmor teardown"
  ignore_failure false
end

# 4.x+
# TODO Still failing:
include_recipe "mysql::server"
#include_recipe "mysql::client"

# TODO -- test and enable for more security
# Change apparmor to complain for mysql to allow it to run
#execute "apparmor change mysql to complain" do
#  user "root"
#  command "aa-complain /usr/sbin/mysqld"
#  ignore_failure false
#end
#
#service "apparmor" do
#  action :start
#end
# End TODO

# 5.2 - 5.3
#include_recipe "php"
#include_recipe "php::module_mysql"

# 2.x+
#include_recipe "apache2"
#include_recipe "apache2::mod_php5"
#include_recipe "apache2::mod_rewrite"

# Configure Apache

# Installer file on box and expanded

# Add DB and tables, user

# PHP config file

# chmod files, app config

# iptables

# Add other allowed users
