name               "mspro"
maintainer         "Rapid7, Inc."
license            "BSD"
description        "Installs/Configures Metasploit Pro development environment"
version            "0.1.0"

%w{ debian ubuntu }.each do |os|
  supports os
end
