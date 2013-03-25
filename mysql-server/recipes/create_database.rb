ruby_block "create_database" do
  block do
    require 'mysql'

    password = Mysql.escape_string(node['mysql-server']['root_password'])

    con = Mysql.new("localhost", "root", password, nil, nil, node['mysql-server']['socket'])

    node['mysql-server']['databases'].each do |database|
      con.query("CREATE DATABASE IF NOT EXISTS #{database} DEFAULT CHARSET=UTF8")
    end

    con.close
  end
end
