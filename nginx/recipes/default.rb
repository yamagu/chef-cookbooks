#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

v = node['platform_version'].to_i
rpm_cache_path = "#{Chef::Config[:file_cache_path]}/nginx-release-centos-#{v}-0.el#{v}.ngx.noarch.rpm"

remote_file rpm_cache_path do
  source "http://nginx.org/packages/centos/#{v}/noarch/RPMS/nginx-release-centos-#{v}-0.el#{v}.ngx.noarch.rpm"
  not_if "rpm -qa | grep nginx-release"
  notifies :install, "rpm_package[nginx-repo]", :immediately
end


rpm_package "nginx-repo" do
  source rpm_cache_path
  only_if {::File.exists?(rpm_cache_path)}
  action :nothing
end

package 'nginx'

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end


template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :reload, "service[nginx]"
end
