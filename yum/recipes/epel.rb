#
# Cookbook Name:: epel-release
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
major = node['yum']['releasever'].to_i

if major == 5
  epel_version = '5-4'
elsif major == 6
  epel_version = '6-8'
end

remote_file "#{Chef::Config[:file_cache_path]}/epel-release-#{epel_version}.rpm" do
  source "http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/#{major}/x86_64/epel-release-#{epel_version}.noarch.rpm"
  not_if "rpm -qa | grep epel-release"
  notifies :install, "rpm_package[epel]", :immediately
end


rpm_package "epel" do
  source "#{Chef::Config[:file_cache_path]}/epel-release-#{epel_version}.rpm"
  only_if {::File.exists?("#{Chef::Config[:file_cache_path]}/epel-release-#{epel_version}.rpm")}
  action :nothing
end

template "/etc/yum.repos.d/epel.repo" do
  source "epel.repo.erb"
  mode "644"
  owner "root"
  group "root"
  variables({
    :releasever => major,
    :priority => 10,
    :enabled => 0
  })
end

file "epel-cleanup" do
  path "#{Chef::Config[:file_cache_path]}/epel-release-#{epel_version}.rpm"
  action :delete
end
