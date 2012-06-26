# Debian stable package: 5.0
# Ubuntu repos stable: 5.21
# Actual latest: 6.01
#
# MS currently ships with 5.61TEST4

# TODO Make this OS independent:
package "build-essential"

installer_file = "nmap-6.01.tar.bz2"
expanded_dir = "nmap-6.01"

cookbook_file "/tmp/#{installer_file}" do
  source installer_file
  mode 0755
  owner "root"
  group "root"
end

execute "extract-cd" do
  user "root"
  command "cd /tmp && bzip2 -cd #{installer_file} | tar xf - "
end

execute "configure-make-install" do
  user "root"
  command "cd /tmp/#{expanded_dir} &&
           ./configure &&
           make &&
           make install"
end

execute "version" do
  user "root"
  command "nmap --version"
end
