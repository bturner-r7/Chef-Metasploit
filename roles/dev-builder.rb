name "dev-builder"
description "A development environment suitable for executing certain build steps"
run_list(
  "recipe[vim]",
  "recipe[java]",
  "recipe[nmap]",
  "recipe[openssh]",
  "recipe[postgresql]",
  "recipe[postgresql::server]"
)

