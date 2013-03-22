require 'rubygems'
require 'mysql'

password = Mysql.escape_string(node['mysql-server']['root_password'])

bash 'set root password' do
  flags "-e"
  code <<-EOC
    mysqladmin -u root password "#{password}"
  EOC
  only_if "mysql -u root -e 'show databases;'"
end

con = Mysql.new("localhost", "root", password, nil, nil, node['mysql-server']['socket'])

# set_root_password
con.query("UPDATE mysql.user SET Password=PASSWORD('#{password}') WHERE User='root'")

# remove_anonymous_users
con.query("DELETE FROM mysql.user WHERE User=''")

# remove_remote_root
con.query("DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')")

# remove_test_database
# Dropping test database...
con.query("DROP DATABASE IF EXISTS test")
# Removing privileges on test database...
con.query("DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%'")

# reload_privilege_tables
con.query("FLUSH PRIVILEGES")
con.close
