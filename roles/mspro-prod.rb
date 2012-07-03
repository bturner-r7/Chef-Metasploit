name "mspro-prod"
description "Sets up a Metasploit commercial version with all development and test gems and boots it in production mode"
override_attributes(
  "pro-env" => "production"
)
run_list(
  "role[base-machine]",
  "recipe[mspro]"
)

