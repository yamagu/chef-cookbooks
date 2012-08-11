#
# Cookbook Name:: erlang
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "yum::epel"

remote_file "/etc/yum.repos.d/epel-erlang.repo" do
  source "http://repos.fedorapeople.org/repos/peter/erlang/epel-erlang.repo"
end

package "erlang"
