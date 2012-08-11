#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "yum::remi"

node['php']['packages'].each do |name|
  yum_package name do
    version node['php']['version']
    action :install
    options "--enablerepo=remi"
  end
end
