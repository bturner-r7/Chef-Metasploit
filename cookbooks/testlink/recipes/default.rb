# Sets up Testlink 1.9
# 
# Homepage: http://www.teamst.org/
# Installation guide: http://www.teamst.org/_tldoc/1.8/installation_manual.pdf
# -----------------------------

# Create application dir
directory "/var/www/testlink" do
  mode "0644"
  group "root"
  owner "root"
  action :create
end

# Copy installer file, expand
cookbook_file "/tmp/testlink-1.9.2.tar.gz" do
  source "testlink-1.9.2.tar.gz"
  mode 0755
  owner "root"
  group "root"
end

execute "file-extraction_perm-fix" do
  user "root"
  command "tar -xzf /tmp/testlink-1.9.2.tar.gz -C /var/www/testlink"
  command "mv /var/www/testlink/testlink-1.9.2/* /var/www/testlink"
  command "rm -rf /var/www/testlink/testlink-1.9.2"
  command "chown -R root:root /var/www/testlink"
  # TODO Fix chmod: templates_c, upload_area and logs apache writeable
end

# Add DB and tables, user
execute "DB-setup" do
  user "root"
  command "mysql -u root -proot -e 'CREATE DATABASE testlink'"
  command "mysql -u root -proot testlink < /var/www/testlink/install/sql/mysql/testlink_create_tables.sql"
  command "mysql -u root -proot testlink < /var/www/testlink/install/sql/mysql/testlink_create_default_data.sql"
  # TODO Setup DB user for testlink
end

# PHP config file
# config_db.inc.php

# Configure Apache to serve

# Remove install dir


# iptables
# Add other allowed users
