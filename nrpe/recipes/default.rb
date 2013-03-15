#
# Cookbook Name:: nrpe
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bash "install_nrpe" do
  user "root"
  code "yum #{node['nrpe']['yumopt']} install -y nagios-nrpe nagios-plugins-all"
end

bash "install_nrpe_dependency" do
  user "root"
  code "yum install -y ksh sysstat"
end

cookbook_file "/usr/lib64/nagios/plugins/check_cpu_stats.sh" do
  source "plugins/check_cpu_stats.sh"
  mode 0755
  owner "root"
  group "root"
end

cookbook_file "/usr/lib64/nagios/plugins/check_TomcatApplication.sh" do
  source "plugins/check_TomcatApplication.sh"
  mode 0755
  owner "root"
  group "root"
end

cookbook_file "/usr/lib64/nagios/plugins/check_disk_busy.sh" do
  source "plugins/check_disk_busy.sh"
  mode 0755
  owner "root"
  group "root"
end

cookbook_file "/usr/lib64/nagios/plugins/check_redis.pl" do
  source "plugins/check_redis.pl"
  mode 0755
  owner "root"
  group "root"
end

cookbook_file "/usr/lib64/nagios/plugins/check_mem.pl" do
  source "plugins/check_mem.pl"
  mode 0755
  owner "root"
  group "root"
end

template "/etc/nagios/nrpe.cfg" do
  source "nrpe.cfg.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, "service[nrpe]"
end

service "nrpe" do
  action [ :enable, :start ]
end
