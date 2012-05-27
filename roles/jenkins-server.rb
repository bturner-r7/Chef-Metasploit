name "Jenkins-Server"
description "An instance of Jenkins for use as a CI/build server"
run_list(
  "recipe[jenkins]"
)
