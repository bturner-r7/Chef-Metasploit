name "testlink-server"
description "Instance of TestLink (QA application)"

run_list(
  "recipe[vim]",
  "recipe[testlink]"
) 

override_attributes(
  :mysql => {
    "server_root_password" => "root",
    "bind_address" => "127.0.0.1",
    "version" => ">4.1"
  }
)
