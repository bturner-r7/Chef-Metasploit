name "mspro-prod"
description "A sets up a Metasploit commercial version with all development and test gems and boots it in production mode"
override_attributes(
  "pro-env" => "production"
)
run_list(
  "role[dev-builder]",
  "recipe[mspro]"
)

