include_recipe "apt"
include_recipe "java"

apt_repository "jenkins" do
  uri "http://pkg.jenkins-ci.org/debian"
  key "http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key"
  components ["binary/"]
  action :add
  notifies :run, "execute[apt-get update]", :immediately

  not_if{::File.exists?('/etc/apt/sources.list.d/jenkins-source.list')}
end

# Update apt-get now that we've added the new repo
execute "apt-get update" do
  command "apt-get update"
  ignore_failure true
  action :nothing
end


package "jenkins"

service "jenkins" do
  supports [:stop, :start, :restart]
  action [:start, :enable]
end


# Install plugins
# TODO: make this DRY!
jenkins "github" do
  action :install_plugin
  cli_jar node['jenkins-plugin']['cli-jar']
  url node['jenkins-plugin']['url']
  path node['jenkins-plugin']['path']
end

jenkins "git" do
  action :install_plugin
  cli_jar node['jenkins-plugin']['cli-jar']
  url node['jenkins-plugin']['url']
  path node['jenkins-plugin']['path']
end

jenkins "rubyMetrics" do
  action :install_plugin
  cli_jar node['jenkins-plugin']['cli-jar']
  url node['jenkins-plugin']['url']
  path node['jenkins-plugin']['path']
end

jenkins "brakeman" do
  action :install_plugin
  cli_jar node['jenkins-plugin']['cli-jar']
  url node['jenkins-plugin']['url']
  path node['jenkins-plugin']['path']
end

jenkins "reload config" do
  action :reload_configuration
  cli_jar node['jenkins-plugin']['cli-jar']
  url node['jenkins-plugin']['url']
  path node['jenkins-plugin']['path']
end

# Need to restart for plugins to take effect
service "jenkins" do
  action :restart
end
