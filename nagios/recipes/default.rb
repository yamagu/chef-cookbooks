#
# Cookbook Name:: nagios
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bash "install_nagios" do
  user "root"
  code "yum --enablerepo=epel install -y nagios nagios-plugins-nrpe"
end

service "nagios" do
  action [ :enable, :start ]
end

bash "set_account" do
  user "root"
  code "htpasswd -cb /etc/nagios/passwd #{node['nagios']['admin_user']} #{node['nagios']['admin_password']}"
end

template "/etc/nagios/nagios.cfg" do
  source "nagios.cfg.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, "service[nagios]"
end

template "/etc/nagios/objects/contacts.cfg" do
  source "contacts.cfg.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, "service[nagios]"
end

template "/etc/httpd/conf.d/nagios.conf" do
  source "nagios.conf.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, "service[httpd]"
end

service "httpd"
