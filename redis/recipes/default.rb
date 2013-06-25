#
# Cookbook Name:: redis
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "redis" do
  options node['redis']['version']
  options node['redis']['options']
  action :install
end

service "redis" do
  action [ :enable, :start ]
end
