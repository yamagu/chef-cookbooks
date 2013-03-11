#
# Cookbook Name:: dovecot
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "dovecot"

service "dovecot" do
  supports :status => true, :restart => true, :reload => true
  action :enable
end

#template "/etc/postfix/main.cf" do
#  source "main.cf.erb"
#  owner "root"
#  group 0
#  mode 00644
#  notifies :restart, "service[dovcot]"
#end

service "dovecot" do
  action :start
end
