#
# Cookbook Name:: selinux
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
bash "disable_selinux" do
  user "root"
  code "setenforce 0"
end


template "/etc/selinux/config" do
  source "selinux_config.erb"
  mode "644"
  owner "root"
  group "root"
end

