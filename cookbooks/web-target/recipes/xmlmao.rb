
# Dependencies
package 'git'
include_recipe 'web-target::apache2'

git "/var/www/XMLmao" do
  repository node['web-target']['xmlmao']['git_repo']
  reference node['web-target']['xmlmao']['git_rev']
  action :sync
end
