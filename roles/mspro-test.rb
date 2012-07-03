name "mspro-test"
description "Sets up a Metasploit commercial version with all development and test gems and boots it in test mode"
override_attributes(
  "pro-env" => "test"
)
run_list(
  "role[base-machine]",
  "recipe[mspro]"
)

