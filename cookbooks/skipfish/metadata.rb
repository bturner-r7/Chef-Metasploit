name              "skipfish"
maintainer        "Brandon Turner, Rapid7, Inc."
maintainer_email  "brandon_turner@rapid7.com"
license           "BSD"
description       "Installs/Configures skipfish"
version           "0.1.0"

%w{ debian ubuntu }.each do |os|
  supports os
end

recipe "skipfish::default", "Installs and configures skipfish"
