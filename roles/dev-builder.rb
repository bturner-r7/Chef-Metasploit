name "dev-builder"
description "A development environment suitable for executing certain build steps"
run_list(
  "recipe[java]",
  "recipe[openssh]",
  "recipe[postgresql]",
  "recipe[postgresql::server]"
)

