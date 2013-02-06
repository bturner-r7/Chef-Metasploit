
# Dependencies
package 'git'
include_recipe 'web-target::apache2'

git "/var/www/XSSmh" do
  repository node['web-target']['xssmh']['git_repo']
  reference node['web-target']['xssmh']['git_rev']
  action :sync
end
