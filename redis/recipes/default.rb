#
# Cookbook Name:: redis
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "yum::epel"

package "redis"

service "redis" do
  action [ :enable, :start ]
end
