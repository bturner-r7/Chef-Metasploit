default['user'] = "msbuilder"
default['password'] = "msbuilder"
default['msf-root'] = "/home/#{default['user']}/msf3"
default['pro-root'] = "/home/#{default['user']}/pro"
default['rails-root'] = "#{default['pro-root']}/ui"

# GIT information
default['msf-git-branch'] = "master"
default['pro-git-branch'] = "develop"

# The Rails/Prosvc environment to use
default['pro-env'] = "test"


# Basics
default['rails-database']['username'] = "mspro"
default['rails-database']['adapter'] = "postgresql"
default['rails-database']['password'] = "mspro"
default['rails-database']['host'] = "localhost"
default['rails-database']['port'] = "5432"
default['rails-database']['pool'] = 20
default['rails-database']['timeout'] = 5

# Environments
default['rails-database']['development'] = "pro_dev"
default['rails-database']['test'] = "pro_test"
default['rails-database']['production'] = "pro_prod"

default['prosvc']['path'] = "#{default['pro-root']}/engine/prosvc.rb"
default['prosvc']['env'] = default['pro-env']
