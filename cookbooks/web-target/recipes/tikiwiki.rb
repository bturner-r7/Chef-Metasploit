tiki_dir = "/var/www/tikiwiki-#{node['web-target']['tikiwiki']['version']}"

# Dependencies
package 'wget'
gem_package 'faker'
gem_package 'faker-medical'
gem_package 'faker_credit_card'
gem_package 'mysql'
include_recipe 'web-target::apache2'
include_recipe "web-target::mysql"

%w{tikiwiki-create-lorem-pages tikiwiki-create-persona-pages tikiwiki-reset-pages}.each do |script|
  template "/usr/local/bin/#{script}" do
    source "#{script}.rb.erb"
    mode 0750
  end
end

bash "install-tikiwiki" do
  creates "#{tiki_dir}/index.php"
  code <<-EOH
    mkdir -p #{tiki_dir}
    cd #{tiki_dir}
    wget -q -O - '#{node['web-target']['tikiwiki']['download_url']}' | tar --strip-components=1 -xjf -
    sed -i 's|#!/bin/sh|#!/bin/bash|' setup.sh
    chmod 0755 setup.sh
    ./setup.sh #{node['apache']['user']} #{node['apache']['group']}
    find #{tiki_dir}/db -name \\*.sql -exec sed -i 's/TYPE=MyISAM/ENGINE=MyISAM/g' {} \\;
    find #{tiki_dir}/db -name \\*.sql -exec sed -i 's/timestamp(14)/timestamp/g' {} \\;
  EOH
end

template "#{tiki_dir}/db/local.php" do
  source "tikiwiki-config.php.erb"
  user node['apache']['user']
  group node['apache']['group']
  mode 0644
end

# TODO: We create the database manually
# We may want to take the time to simulate doing this via wget as the installation
# script may do more than just execute sql
bash "create-database" do
  code <<-EOH
    mysqladmin -u root -p#{node['mysql']['server_root_password']} create #{node['web-target']['tikiwiki']['db_name']}
    mysql -u root -p#{node['mysql']['server_root_password']} #{node['web-target']['tikiwiki']['db_name']} < #{tiki_dir}/db/tiki.sql
    mysql -u root -p#{node['mysql']['server_root_password']} #{node['web-target']['tikiwiki']['db_name']} -e "UPDATE users_users SET hash=MD5('admin#{node['web-target']['tikiwiki']['admin_pass']}'), pass_due=1500000000, password=NULL"
    wget -q -o /dev/null http://127.0.0.1/tikiwiki-#{node['web-target']['tikiwiki']['version']}/tiki-index.php
    /usr/local/bin/tikiwiki-create-lorem-pages >/dev/null
    /usr/local/bin/tikiwiki-create-persona-pages 100 >/dev/null
  EOH
  not_if { FileTest.directory?("/var/lib/mysql/#{node['web-target']['tikiwiki']['db_name']}") }
end
