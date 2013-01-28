name "SSH only"
description "For when you just want remote login and nothing else yet"
run_list(
  "recipe[openssh]"
)


