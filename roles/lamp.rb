name "LAMP-stack"
description "For playing w/ Apache, MySQL, PHP"
run_list(
  "recipe[vim]",
  "recipe[apache2]",
  "recipe[mysql]",
  "recipe[openssh]",
)

