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
  mode 0644
  owner "root"
  group "root"
  notifies :restart, "service[httpd]"
end


file "/var/www/error/noindex.html" do
  backup false
end

if node['httpd']['auth']['enabled']
  bash "set_account" do
    user "root"
    code "htpasswd -cb #{node['httpd']['auth']['user_file']} #{node['httpd']['auth']['user']} #{node['httpd']['auth']['password']}"
  end
end
service "httpd" do
  action [ :enable, :start ]
end

