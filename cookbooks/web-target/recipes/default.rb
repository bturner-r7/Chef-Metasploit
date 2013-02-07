
# Depedencies
include_recipe "web-target::apache2"
include_recipe "web-target::mysql"
include_recipe "web-target::postgresql"
include_recipe "web-target::tomcat"

# Web apps
include_recipe "web-target::dvwa"
include_recipe "web-target::shellol"
include_recipe "web-target::sqlol"
include_recipe "web-target::tikiwiki"
include_recipe "web-target::webdav"

include_recipe "web-target::websploit-tests"

include_recipe "web-target::xmlmao"
include_recipe "web-target::xssmh"
