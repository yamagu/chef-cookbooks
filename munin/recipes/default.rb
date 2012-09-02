#
# Cookbook Name:: munin
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "munin"


template "/etc/munin/munin.conf" do
  source "munin.conf.erb"
  mode "644"
  owner "root"
  group "root"
end
