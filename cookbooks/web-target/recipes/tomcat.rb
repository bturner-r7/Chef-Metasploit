
include_recipe "tomcat"

template "/etc/tomcat6/tomcat-users.xml" do
  cookbook "tomcat"
  source "tomcat-users.xml.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    :users => [
      {'id' => 'tomcat', 'password' => 'tomcat', 'roles' => ['tomcat', 'manager-gui']},
      {'id' => 'both', 'password' => 'tomcat', 'roles' => ['tomcat', 'role1']},
      {'id' => 'role1', 'password' => 'tomcat', 'roles' => ['role1']}
    ],
    :roles => ['tomcat', 'role1']
  )
  notifies :restart, resources(:service => "tomcat")
end
