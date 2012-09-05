default['mysql-server']['version'] = ""

default['mysql-server']['datadir'] = "/var/lib/mysql"
default['mysql-server']['socket'] = "/var/lib/mysql/mysql.sock"

default['mysql-server']['server_id'] = "1"
default['mysql-server']['max_connections'] = "200"

# innodb_buffer_pool_size
memory_kb = node[:memory][:total].scan(/[0-9]+/)[0].to_i
memory_mb = memory_kb / 1024
default['mysql-server']['innodb_buffer_pool_size'] = (memory_mb * 0.7).truncate.to_s + "M"

default['mysql-server']['innodb_log_files_in_group'] = "2"

