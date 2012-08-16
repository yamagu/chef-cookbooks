#
# Cookbook Name:: httpd
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "httpd"

template "/etc/httpd/conf/httpd.conf" do
  source "httpd.conf.erb"
  mode "644"
  owner "root"
  group "root"
end


file "/var/www/error/noindex.html" do
  backup false
end

service "httpd" do
  action [ :enable, :start ]
end

