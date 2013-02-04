name "LAMP stack"
description "For playing w/ Apache, MySQL, PHP"
run_list(
  "recipe[vim]",
  "recipe[apache2]",
  "recipe[php]",
  "recipe[mysql]",
  "recipe[openssh]",
)

