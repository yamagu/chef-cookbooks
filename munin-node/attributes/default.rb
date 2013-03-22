default['munin-node']['version'] = nil
default['munin-node']['options'] = "--enablerepo=epel"
default['munin-node']['allow_hosts'] = ["^127\.0\.0\.1$", "^::1$"]

default['munin-node']['apache']['plugins'] = %w{ apache_accesses apache_processes apache_volume }

default['munin-node']['mysql']['plugins'] = %w{ mysql_bytes mysql_threads mysql_queries mysql_slowqueries }
default['munin-node']['mysql']['contrib_plugins'] = %w{ mysql_connections mysql_qcache_mem mysql_qcache mysql_size_all mysql_slave mysql_report mysql-schema-size mysql_size_ }
default['munin-node']['mysql']['mysqlopts'] = "-u**** -p****"
default['munin-node']['mysql']['mysqladmin'] = "/usr/bin/mysqladmin"
