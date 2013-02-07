name               "mutilidae"
maintainer         "Rapid7, Inc."
license            "BSD"
description        "Installs/Configures Mutilidae"
version            "0.1.0"

%w{ apache2 perl php mysql }.each do |cb|
  depends cb
end

%w{ debian ubuntu }.each do |os|
  supports os
end
