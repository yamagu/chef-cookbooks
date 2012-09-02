
link "/etc/munin/plugins/apache_accesses" do
    to "/usr/share/munin/plugins/apache_accesses"
end

link "/etc/munin/plugins/apache_processes" do
    to "/usr/share/munin/plugins/apache_processes"
end

link "/etc/munin/plugins/apache_volume" do
    to "/usr/share/munin/plugins/apache_volume"
end


service "munin-node" do
  action :restart
end
