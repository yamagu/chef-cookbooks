#
# Cookbook Name:: rabbitmq
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
case node['platform']
when "redhat", "centos", "scientific", "amazon", "fedora"
  remote_file "#{Chef::Config[:file_cache_path]}/rabbitmq-server-2.8.5-1.noarch.rpm" do
    source "http://www.rabbitmq.com/releases/rabbitmq-server/v2.8.5/rabbitmq-server-2.8.5-1.noarch.rpm"
    action :create_if_missing
  end

  rpm_package "#{Chef::Config[:file_cache_path]}/rabbitmq-server-2.8.5-1.noarch.rpm" do
    action :install
  end
end

service "rabbitmq-server" do
    action [ :enable, :start ]
end
