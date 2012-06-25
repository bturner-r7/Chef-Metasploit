name "testlink-server"
description "Instance of TestLink (QA application)"

run_list(
  "recipe[vim]",
  "recipe[openssl::default]",
  "recipe[mysql::server]",
  "recipe[apache2]",
  # PHP5.2 for 1.8, 5.2/5.3 for 1.9
  "recipe[apache2::mod_php5]",
  "recipe[apache2::mod_rewrite]",
  "recipe[testlink]"
) 

override_attributes(
  :mysql => {
    "server_root_password" => "root",
    "bind_address" => "127.0.0.1",
    "version" => ">4.1"
    # innodb_flush_method must not be passed if default is desired,
    # remove from mysql cookbook server attrs and my.cnf.erb. 
    # If a particular different value is desired you can add it back and set it.
    # Passing the old default value will result in error.
  }
)
