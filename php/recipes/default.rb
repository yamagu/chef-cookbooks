#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "yum::remi"

execute "remi_enabled" do
  command "perl -p -i.bak -e 's/enabled=0/enabled=1/' /etc/yum.repos.d/remi.repo"
end


node['php']['packages'].each do |name|
  yum_package name do
    version node['php']['version']
    action :install
    options "--enablerepo=remi"
  end
end

execute "remi_disabled" do
  command "perl -p -i.bak -e 's/enabled=1/enabled=0/' /etc/yum.repos.d/remi.repo"
end
