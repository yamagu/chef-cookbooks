#
# Cookbook Name:: mysql-server
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "yum::remi-enabled"

%w{ mysql-server mysql mysql-devel }.each do |name|
  cmd = "yum install -y --enablerepo=remi #{name}"

  if node['mysql-server']['version'].length > 0
    cmd = "#{cmd}-#{node['mysql-server']['version']}"
  end

  bash "install_mysql" do
    user "root"
    code cmd
  end
end

include_recipe "yum::remi-disabled"

template "/etc/my.cnf" do
  source "my.cnf.erb"
  mode "644"
  owner "root"
  group "root"
  notifies :restart, "service[mysqld]"
end

service "mysqld" do
  action [ :enable, :start ]
end

