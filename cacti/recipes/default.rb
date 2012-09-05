#
# Cookbook Name:: cacti
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "php::snmp"

package "cacti"
package "net-snmp-utils"

template "/usr/share/cacti/include/config.php" do
  source "config.php.erb"
  mode 0644
  owner "root"
  group "root"
end

template "/etc/httpd/conf.d/cacti.conf" do
  source "cacti.conf.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, "service[httpd]"
end

template "/etc/cron.d/cacti" do
  source "cron.d.cacti.erb"
  mode 0644
  owner "root"
  group "root"
end

