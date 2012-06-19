include_recipe "apt"

apt_repository "nmap" do
  uri "http://packages.debian.org/stable/nmap"
  notifies :run, "execute[apt-get update]", :immediately
end

package "nmap"
