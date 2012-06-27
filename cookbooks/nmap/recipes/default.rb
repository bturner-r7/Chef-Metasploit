already_installed = File.exists? "/usr/local/bin/nmap"

if not already_installed
  include_recipe "nmap::conditional-nmap"
end
