#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#include_recipe "yum::remi-enabled"

packages = node['php']['packages'].map do |name|
  if node['php']['version'].length > 0
    "#{name}-#{node['php']['version']}"
  else
    name
  end
end

bash "install_lib" do
  user "root"
  code "yum -y install --enablerepo=epel libmcrypt-devel"
end

bash "install_php" do
  user "root"
  code "yum install -y --enablerepo=remi,epel #{packages.join(' ')}"
end
template "/etc/php.ini" do
  source "php.ini.erb"
  mode "644"
  owner "root"
  group "root"
  if node['httpd']['service_enable']
    notifies :restart, "service[httpd]"
  end
end

#include_recipe "yum::remi-disabled"
