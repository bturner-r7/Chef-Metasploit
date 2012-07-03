name "base-machine"
description "A development environment"
run_list(
  "recipe[vim]",
  "recipe[java]",
  "recipe[openssh]",
  "recipe[postgresql]",
  "recipe[postgresql::server]",
  "recipe[nmap]"
)

