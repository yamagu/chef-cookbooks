#
# Cookbook Name:: python-boto
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "python-boto" do
  version node['python-boto']['version']
  options node['python-boto']['options']
  action :install
end
