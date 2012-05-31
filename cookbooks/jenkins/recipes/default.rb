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

# Get the latest Jenkins update center info so we can install plugins
# curl thanks to Gist: https://gist.github.com/1026918
execute "update-center" do
  command "curl  -L http://updates.jenkins-ci.org/update-center.json | sed '1d;$d' | curl -X POST -H 'Accept: application/json' -d @- http://localhost:8080/updateCenter/byId/default/postBack"
  action :run
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

# Provides a way of doing "release" steps
jenkins "release" do
  action :install_plugin
  cli_jar node['jenkins-plugin']['cli-jar']
  url node['jenkins-plugin']['url']
  path node['jenkins-plugin']['path']
end

# Provides static analysis stuff like RCov, etc
jenkins "rubyMetrics" do
  action :install_plugin
  cli_jar node['jenkins-plugin']['cli-jar']
  url node['jenkins-plugin']['url']
  path node['jenkins-plugin']['path']
end

# Does security-oriented static analysis of code for Rails vulns
jenkins "brakeman" do
  action :install_plugin
  cli_jar node['jenkins-plugin']['cli-jar']
  url node['jenkins-plugin']['url']
  path node['jenkins-plugin']['path']
end

# For creating promotion chains in Jenkins
jenkins "promoted-builds" do
  action :install_plugin
  cli_jar node['jenkins-plugin']['cli-jar']
  url node['jenkins-plugin']['url']
  path node['jenkins-plugin']['path']
end

# Dep of IRC plugin
jenkins "instant-messaging" do
  action :install_plugin
  cli_jar node['jenkins-plugin']['cli-jar']
  url node['jenkins-plugin']['url']
  path node['jenkins-plugin']['path']
end

# Info and commands from IRC!
jenkins "ircbot" do
  action :install_plugin
  cli_jar node['jenkins-plugin']['cli-jar']
  url node['jenkins-plugin']['url']
  path node['jenkins-plugin']['path']
end

# Changes passing build color from blue to green, because green means go!
jenkins "greenballs" do
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
