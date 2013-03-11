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

bash "set_account" do
  user "root"
  code "htpasswd -cb /etc/nagios/passwd #{node['nagios']['admin_user']} #{node['nagios']['admin_password']}"
end

service "nagios" do
  action [ :enable, :start ]
end
