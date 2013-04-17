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

if node['postfix']['virtual_mailbox']['enabled']
  vbox_dir = "#{node['postfix']['virtual_mailbox']['virtual_mailbox_base']}/#{node['postfix']['virtual_mailbox']['virtual_mailbox_domains']}"
  directory vbox_dir do
    owner node['postfix']['virtual_mailbox']['virtual_uid']
    group node['postfix']['virtual_mailbox']['virtual_gid']
    recursive true
    action :create
  end

  execute "update-postfix-vmailbox" do
    command "postmap /etc/postfix/vmailbox"
    action :nothing
  end


  template "/etc/postfix/vmailbox" do
    mode "644"
    source "vmailbox.erb"
    notifies :run, "execute[update-postfix-vmailbox]"
  end

  execute "update-postfix-virtual_alias_maps" do
    command "postmap /etc/postfix/virtual"
    action :nothing
  end


  template "/etc/postfix/virtual" do
    mode "644"
    source "virtual.erb"
    notifies :run, "execute[update-postfix-virtual_alias_maps]"
  end
end


if node['postfix']['smtp_auth']['enabled']
  execute "chown sasldb2" do
    command "chown postfix:postfix /etc/sasldb2"
  end
end

template "/etc/postfix/master.cf" do
  source "master.cf.erb"
  owner "root"
  group 0
  mode 00644
  notifies :restart, "service[postfix]"
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
