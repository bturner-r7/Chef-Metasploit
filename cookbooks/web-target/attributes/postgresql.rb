
default[:postgresql][:users] = [
  {
    :username => 'msfadmin',
    :password => 'msfadmin',
    :superuser => true,
    :login => true
  }
]
