include_recipe "apt"
include_recipe "java"

apt_repository "jenkins" do
  uri "http://pkg.jenkins-ci.org/debian"
  key "http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key"
  components ["binary/"]
  action :add
  notifies :run, "apt-get update", :immediately
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

# Activate CLI
script "download-jenkins-cli" do
  interpreter "bash"
  user "root"
  cwd "/var/run/jenkins/war/WEB-INF"
  code <<-EOH
  wget http://localhost:8080/jnlpJars/jenkins-cli.jar
  EOH
end


# Install plugins
jenkins "github" do
  action :install_plugin
  cli_jar node['jenkins-plugin']['cli-jar']
  url "http://localhost:8080"
  path "/var/lib/jenkins"
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
