ruby_block "set privileges" do
  block do
    require 'mysql'

    root_password = Mysql.escape_string(node['mysql-server']['root_password'])
    con = Mysql.new("localhost", "root", root_password, nil, nil, node['mysql-server']['socket'])

    node['mysql-server']['privileges'].each do |priv|
      username = con.escape_string(priv['username'])
      password = con.escape_string(priv['password'])

      db_name = "*.*"
      db_name = "#{priv['db_name']}.*" if priv['db_name']

      hosts = ["localhost"]
      hosts = priv['hosts'] if priv['hosts']

      case priv['role']
      when 'admin'
        hosts.each do |host|
          con.query("GRANT ALL PRIVILEGES on *.* TO '#{username}'@'#{host}' IDENTIFIED BY '#{password}' WITH GRANT OPTION")
        end
      when 'user'
        priv_types = node['mysql-server']['default_priv_types']
        priv_types = priv['priv_types'] if priv['priv_types']

        hosts.each do |host|
          con.query("GRANT #{priv_types.join(', ')} on #{db_name} TO '#{username}'@'#{host}' IDENTIFIED BY '#{password}'")
        end
      else
        raise "only 'admin' and 'user' role are supported!"
      end
    end

    con.query("FLUSH PRIVILEGES")
    con.close
  end
end


