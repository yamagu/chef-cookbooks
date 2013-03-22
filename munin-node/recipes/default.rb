#
# Cookbook Name:: munin-node
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "munin-node" do
  version node['munin-node']['version']
  options node['munin-node']['options']
  action :install
end

package "sysstat"

service "munin-node" do
  action [ :enable, :start ]
  supports :restart => true
end
