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
  yum_package name do
    version node['mysql-server']['version']
    action :install
    options "--enablerepo=remi"
  end
end

include_recipe "yum::remi-disabled"

template "/etc/my.cnf" do
  source "my.cnf.erb"
  mode "644"
  owner "root"
  group "root"
end

service "mysqld" do
  action [ :enable, :start ]
end

