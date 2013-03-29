#
# Cookbook Name:: sasl
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "cyrus-sasl"
package "cyrus-sasl-lib"


template "/etc/sasl2/smtpd.conf" do
  source "smtpd.conf.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, "service[postfix]"
end

node['sasl']['users'].each do |user|
  bash "saslpassword" do
    code "echo '#{user['password']}' | saslpasswd2 -p -u #{user['domain']} -c #{user['name']}"
    not_if "sasldblistusers2 |grep #{user['name']}@#{user['domain']}"
  end
end

service "postfix" do
  supports :restart => true, :reload => true
end
