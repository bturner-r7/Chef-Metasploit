name               "nmap"
maintainer         "Rapid7, Inc."
license            "BSD"
description        "Installs/Configures nmap"
version            "0.1.0"

%w{ build-essential }.each do |cb|
  depends cb
end

%w{ debian ubuntu }.each do |os|
  supports os
end
