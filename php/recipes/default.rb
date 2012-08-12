#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "yum::remi-enabled"

node['php']['packages'].each do |name|
  yum_package name do
    version node['php']['version']
    action :install
    # flush_cache [:before, :after]
    options "--enablerepo=remi"
  end
end

include_recipe "yum::remi-disabled"
