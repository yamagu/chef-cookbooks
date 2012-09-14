
template "/etc/httpd/conf.d/vhost.conf" do
  source "vhost.conf.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, "service[httpd]"
end
