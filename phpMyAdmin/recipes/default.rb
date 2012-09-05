#
# Cookbook Name:: phpMyAdmin
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

bash "install_php_my_admin" do
  user "root"
  cwd "/usr/local/src"
  code <<-EOH
if [ !-d /usr/share/phpMyAdmin ]; then
  wget -O phpMyAdmin-3.5.2.2-all-languages.tar.gz http://sourceforge.net/projects/phpmyadmin/files/phpMyAdmin/3.5.2.2/phpMyAdmin-3.5.2.2-all-languages.tar.gz &&
  tar xvzf phpMyAdmin-3.5.2.2-all-languages.tar.gz &&
  mv phpMyAdmin-3.5.2.2-all-languages /usr/share/phpMyAdmin
fi
  EOH
end

template "/etc/httpd/conf.d/phpMyAdmin.conf" do
  source "phpMyAdmin.conf.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, "service[httpd]"
end
