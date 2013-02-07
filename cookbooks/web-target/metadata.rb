name              "web-target"
maintainer        "Brandon Turner, Rapid7, Inc."
maintainer_email  "brandon_turner@rapid7.com"
license           "BSD"
description       "Installs/Configures purposefully vulnerable web apps for testing"
version           "0.1.0"

%w{ apache2 java mysql postgresql tomcat }.each do |cb|
  depends cb
end

%w{ debian ubuntu }.each do |os|
  supports os
end

recipe "web-target::default", "Installs and configures several vulnerable apps"
recipe "web-target::apache2", "Configure apache for serving vulnerable apps"
recipe "web-target::dvwa", "Configure Damn-Vulnerable-Web-App"
recipe "web-target::mysql", "Configure MySQL for web-app backends"
recipe "web-target::postgresql", "Configure Postgres for web-app backends"
recipe "web-target::shellol", "Configure ShelLOL for OS command injection vulns"
recipe "web-target::sqlol", "Configure SQLoL for SQLi vulns"
recipe "web-target::tikiwiki", "Configure vulnerable TikiWiki with fake data"
recipe "web-target::tomcat", "Configure Tomcat with vulnerable manager"
recipe "web-target::webdav", "Configure anauthenticate webdav folder"
recipe "web-target::websploit-tests", "Configure WebSploit-Tests web vulns"
recipe "web-target::xmlmao", "Configure XMLmao for XML/XPATH injection vulns"
recipe "web-target::xmlmh", "Configure XSSmh for cross-site scripting vulns"
