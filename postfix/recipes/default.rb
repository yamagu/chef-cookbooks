#
# Cookbook Name:: postfix
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "postfix"

service "postfix" do
  supports :status => true, :restart => true, :reload => true
  action :enable
end

case node['platform_family']
when "rhel", "fedora"

  service "sendmail" do
    action :nothing
  end

  execute "switch_mailer_to_postfix" do
    command "/usr/sbin/alternatives --set mta /usr/sbin/sendmail.postfix"
    notifies :stop, "service[sendmail]"
    notifies :start, "service[postfix]"
    not_if "/usr/bin/test /etc/alternatives/mta -ef /usr/sbin/sendmail.postfix"
  end

end

template "/etc/postfix/main.cf" do
  source "main.cf.erb"
  owner "root"
  group 0
  mode 00644
  notifies :restart, "service[postfix]"
end

service "postfix" do
  action :start
end
