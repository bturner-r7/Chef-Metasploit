
# Dependencies
package 'git'
include_recipe 'web-target::apache2'

git "/var/www/SQLol" do
  repository node['web-target']['sqlol']['git_repo']
  reference node['web-target']['sqlol']['git_rev']
  action :sync
end
