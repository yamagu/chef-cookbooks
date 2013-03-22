service "munin-node" do
  supports :restart => true
end

node['munin-node']['mysql']['plugins'].each do |plugin_name|
  link "/etc/munin/plugins/#{plugin_name}" do
    to "/usr/share/munin/plugins/#{plugin_name}"
  end
end

# mysql_contrib_plugin

node['munin-node']['mysql']['contrib_plugins'].each do |plugin_name|
  link "/etc/munin/plugins/#{plugin_name}" do
    to "/usr/share/munin/plugins/#{plugin_name}"
    only_if "test -d /usr/share/munin/contrib"
  end
end

template "/etc/munin/plugin-conf.d/mysql" do
  source "munin-node-mysql.erb"
  mode "644"
  owner "root"
  group "root"
  notifies :restart, "service[munin-node]"
end

