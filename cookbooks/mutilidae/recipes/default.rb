include_recipe "apache"
include_recipe "perl"
include_recipe "php"
include_recipe "mysql"


# Get Mutilidae itself - make it webroot
remote_file "/var/www/" do
  source  "http://sourceforge.net/projects/mutillidae/files/latest/download?source=files"
end

service "apache2" do
  action :restart
end




