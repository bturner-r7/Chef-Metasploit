
# Dependencies
package 'git'
include_recipe 'web-target::apache2'

git "/var/www/Websploit-Tests" do
  repository node['web-target']['websploit-tests']['git_repo']
  reference node['web-target']['websploit-tests']['git_rev']
  action :sync
end
