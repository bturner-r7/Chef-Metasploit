#
# Pulled from: https://github.com/phlipper/chef-postgresql
#
# Examples:
#   # create a user
#   pg_user "myuser" do
#     privileges :superuser => false, :createdb => false, :login => true
#     password "mypassword"
#   end
#
#   # create a user with an MD5-encrypted password
#   pg_user "myuser" do
#     privileges :superuser => false, :createdb => false, :login => true
#     encrypted_password "667ff118ef6d196c96313aeaee7da519"
#   end
#
#   # drop a user
#   pg_user "myuser" do
#     action :drop
#   end

define :pg_user, :action => :create do
  case params[:action]
  when :create
    privileges = {
      :superuser => false,
      :createdb => false,
      :login => true,
      :replication => false
    }
    privileges.merge! params[:privileges] if params[:privileges]

    sql = [params[:name]]

    sql.push privileges.to_a.map! { |p,b| (b ? '' : 'NO') + p.to_s.upcase }.join ' '

    if params[:encrypted_password]
      sql.push "ENCRYPTED PASSWORD '#{params[:encrypted_password]}'"
    elsif params[:password]
      sql.push "PASSWORD '#{params[:password]}'"
    end

    sql = sql.join ' '

    exists = ["psql -c \"SELECT usename FROM pg_user WHERE usename='#{params[:name]}'\""]
    exists.push "| grep #{params[:name]}"
    exists = exists.join ' '

    execute "altering pg user #{params[:name]}" do
      user "postgres"
      command "psql -c \"ALTER ROLE #{sql}\""
      only_if exists, :user => "postgres"
    end

    execute "creating pg user #{params[:name]}" do
      user "postgres"
      command "psql -c \"CREATE ROLE #{sql}\""
      not_if exists, :user => "postgres"
    end

  when :drop
    execute "dropping pg user #{params[:name]}" do
      user "postgres"
      command "psql -c \"DROP ROLE IF EXISTS #{params[:name]}\""
    end
  end
end
