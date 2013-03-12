#
# Cookbook Name:: munin
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bash "install_munin" do
  user "root"
  code "yum --enablerepo=epel install -y munin"
end


bash "set_account" do
  user "root"
  code "htpasswd -cb /etc/munin/munin-htpasswd #{node['munin']['admin_user']} #{node['munin']['admin_password']}"
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
