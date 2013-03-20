
node['munin-node']['apache']['plugins'].each do |plugin_name|
  link "/etc/munin/plugins/#{plugin_name}" do
    to "/usr/share/munin/plugins/#{plugin_name}"
  end
end

service "munin-node" do
  supports :restart => true
  action :restart
end
