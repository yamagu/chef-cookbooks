#
# Cookbook Name:: dovecot
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "dovecot"

service "dovecot" do
  supports :status => true, :restart => true, :reload => true
  action :enable
end

template "/etc/dovecot/dovecot.conf" do
  source "dovecot.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[dovecot]"
end

if node['dovecot']['passwd-file']['enabled']
  template "/etc/dovecot/conf.d/10-auth.conf" do
    source "10-auth.conf.erb"
    owner "root"
    group "root"
    mode 0644
    notifies :restart, "service[dovecot]"
  end
  template "/etc/dovecot/conf.d/auth-passwdfile.conf.ext" do
    source "auth-passwdfile.conf.ext.erb"
    owner "root"
    group "root"
    mode 0644
    notifies :restart, "service[dovecot]"
  end
  dovecot_users = []
  node['dovecot']['passwd-file']['users'].each do |user|
    dovecot_user = {}
    dovecot_user['name'] = user['name']
    dovecot_user['password'] = `doveadm pw -s #{user['mechanism']} -p #{user['password']}`.chomp
    dovecot_users << dovecot_user
  end

  template node['dovecot']['passwd-file']['path'] do
    source "dovecot.passwd.erb"
    owner "root"
    group "root"
    mode 0644
    variables({
      :users => dovecot_users
    })
    notifies :restart, "service[dovecot]"
  end

end
service "dovecot" do
  action :start
end
