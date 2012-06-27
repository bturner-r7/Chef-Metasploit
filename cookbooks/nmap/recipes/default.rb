already_installed = File.exists? "/usr/local/bin/nmap"

if not already_installed
  include_recipe "nmap::conditional-nmap"
else
  Chef::Log.info "nmap appears to be installed already."
end
