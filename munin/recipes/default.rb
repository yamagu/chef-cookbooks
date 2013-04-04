#
# Cookbook Name:: munin
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "munin" do
  version node['munin']['version']
  options node['munin']['options']
  action :install
end

service "httpd" do
  supports :restart => true
end

bash "set_account" do
  user "root"
  code "htpasswd -cb /etc/munin/munin-htpasswd #{node['munin']['admin_user']} #{node['munin']['admin_password']}"
end

bash "set_htmldir" do
  user "root"
  code "mv /var/www/html/munin #{node['munin']['htmldir']}"
  only_if "test /var/www/html/munin != #{node['munin']['htmldir']} && test -d /var/www/html/munin && test ! -d #{node['munin']['htmldir']}"
end

template "/etc/munin/munin.conf" do
  source "munin.conf.erb"
  mode "644"
  owner "root"
  group "root"
end

template "/etc/httpd/conf.d/munin.conf" do
  source "munin.httpd.conf.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, "service[httpd]"
end

