# -- General env settings
default['user'] = "msbuilder"
default['msf-root'] = "/home/#{default['user']}/msf3"
default['pro-root'] = "/home/#{default['user']}/pro"
default['rails-root'] = "#{default['pro-root']}/ui"

# -- Database and connection info
default['rails-database']['adapter'] = "adapter"
default['rails-database']['host'] = "localhost"
default['rails-database']['port'] = "5432"
default['rails-database']['password'] = "mspro"
default['rails-database']['username'] = "mspro"
default['rails-database']['pool'] = 20
default['rails-database']['timeout'] = 5

default['rails-database']['development'] = "pro_dev"
default['rails-database']['test'] = "pro_test"
default['rails-database']['production'] = "pro_prod"

# -- Prosvc service settings
default['prosvc']['path'] = "#{default['pro-root']}/engine/prosvc.rb"
default['prosvc']['mode'] = "development"
