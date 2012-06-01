name "mspro-prod"
description "A sets up a Metasploit commercial version with all development and test gems and boots it in production mode"
run_list(
  "recipe[vim]",
  "recipe[java]",
  "recipe[openssh]",
  "recipe[postgresql]",
  "recipe[postgresql::server]",
  "recipe[mspro]",
)

