bash "enable_mysql_plugin" do
  user "root"
  cwd "/usr/share/munin"
  code <<-EOH
ln -sf /usr/share/munin/plugins/mysql_bytes /etc/munin/plugins/mysql_bytes
ln -sf /usr/share/munin/plugins/mysql_threads /etc/munin/plugins/mysql_threads
ln -sf /usr/share/munin/plugins/mysql_queries /etc/munin/plugins/mysql_queries
ln -sf /usr/share/munin/plugins/mysql_slowqueries /etc/munin/plugins/mysql_slowqueries
  EOH
end

bash "install_contrib_mysql" do
  user "root"
  cwd "/usr/share/munin"
  code <<-EOH
if [ !-d  contrib]; then
git clone git://github.com/munin-monitoring/contrib.git contrib
fi
  EOH
end

bash "enable_mysql_contrib_plugin" do
  user "root"
  cwd "/usr/share/munin"
  code <<-EOH
ln -sf /usr/share/munin/contrib/plugins/mysql/mysql_connections /etc/munin/plugins/mysql_connections
ln -sf /usr/share/munin/contrib/plugins/mysql/mysql_qcache_mem /etc/munin/plugins/mysql_qcache_mem
ln -sf /usr/share/munin/contrib/plugins/mysql/mysql_qcache /etc/munin/plugins/mysql_qcache
ln -sf /usr/share/munin/contrib/plugins/mysql/mysql_size_all /etc/munin/plugins/mysql_size_all
ln -sf /usr/share/munin/contrib/plugins/mysql/mysql_slave /etc/munin/plugins/mysql_slave

ln -sf /usr/share/munin/contrib/plugins/mysql/mysql_report /etc/munin/plugins/mysql_report
ln -sf /usr/share/munin/contrib/plugins/mysql/mysql-schema-size /etc/munin/plugins/mysql-schema-size
ln -sf /usr/share/munin/contrib/plugins/mysql/mysql_size_ /etc/munin/plugins/mysql_size_
  EOH
end


template "/etc/munin/plugin-conf.d/mysql" do
  source "munin-node-mysql.erb"
  mode "644"
  owner "root"
  group "root"
end

service "munin-node" do
  action :restart
end
