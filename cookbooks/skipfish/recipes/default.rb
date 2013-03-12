skipfish_dir = "/opt/skipfish-#{node['skipfish']['version']}"

# Dependencies
package 'wget'
package 'libpcre3'
package 'libpcre3-dev'
package 'libidn11'
package 'libidn11-dev'

directory skipfish_dir do
  owner node['skipfish']['user']
  group node['skipfish']['group']
  mode 0755
  action :create
end

bash "download-skipfish" do
  creates "#{skipfish_dir}/Makefile"
  code <<-EOH
    cd #{skipfish_dir}
    wget -q -O - '#{node['skipfish']['download_url']}' | tar --strip-components=1 -xzf -
  EOH
  user node['skipfish']['user']
end

execute "compile-skipfish" do
  cwd skipfish_dir
  user node['skipfish']['user']
  command "make"
  creates "#{skipfish_dir}/skipfish"
end
