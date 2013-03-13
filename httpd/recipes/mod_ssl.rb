package "mod_ssl"

template "/etc/httpd/conf.d/ssl.conf" do
  source "ssl.conf.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, "service[httpd]"
end


file "/var/www/error/noindex.html" do
  backup false
end

service "httpd"
