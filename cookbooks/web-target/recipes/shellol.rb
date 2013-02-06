
# Dependencies
package 'git'
include_recipe 'web-target::apache2'

git "/var/www/ShelLOL" do
  repository node['web-target']['shellol']['git_repo']
  reference node['web-target']['shellol']['git_rev']
  action :sync
end
