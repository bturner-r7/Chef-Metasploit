name "mspro-dev"
description "Sets up a Metasploit commercial version with all development and test gems and boots it in development mode"
override_attributes(
  "pro-env" => "development"
)
run_list(
  "role[base-machine]",
  "recipe[mspro]"
)

