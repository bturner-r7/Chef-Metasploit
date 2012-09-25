include_recipe "apache"
include_recipe "perl"
include_recipe "php"


# Get Mutilidae itself - make it webroot
remote_file "/var/www/" do
  source  "http://sourceforge.net/projects/mutillidae/files/mutillidae-project/LATEST-mutillidae-2.3.7.zip"
end

service "apache2" do
  action :restart
end




