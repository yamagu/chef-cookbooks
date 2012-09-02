#
# Cookbook Name:: munin-node
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "munin-node"
package "sysstat"

service "munin-node" do
  action [ :enable, :start ]
end
