include_recipe "apt"
include_recipe "java"

apt_repository "jenkins" do
  uri "http://pkg.jenkins-ci.org/debian"
  key "http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key"
  components ["binary/"]
  action :add

  notifies :run, "apt[apt-get update]", :immediately
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
  cli_jar "/var/run/jenkins/war/WEB-INF/jenkins-cli.jar"
  url "http://localhost:8080"
  path "/var/lib/jenkins"
end

jenkins "git" do
  action :install_plugin
  cli_jar "/var/run/jenkins/war/WEB-INF/jenkins-cli.jar"
  url "http://localhost:8080"
  path "/var/lib/jenkins"
end

jenkins "rubyMetrics" do
  action :install_plugin
  cli_jar "/var/run/jenkins/war/WEB-INF/jenkins-cli.jar"
  url "http://localhost:8080"
  path "/var/lib/jenkins"
end

jenkins "brakeman" do
  action :install_plugin
  cli_jar "/var/run/jenkins/war/WEB-INF/jenkins-cli.jar"
  url "http://localhost:8080"
  path "/var/lib/jenkins"
end

jenkins "reload config" do
  action :reload_configuration
  cli_jar "/var/run/jenkins/war/WEB-INF/jenkins-cli.jar"
  url "http://localhost:8080"
  path "/var/lib/jenkins"
end
