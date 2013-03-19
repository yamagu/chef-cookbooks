#
# Cookbook Name:: rvm
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


node[:rvm][:users].each do |user|
  pw = Etc.getpwnam(user['name'])

  bash "install rvm" do
    user pw.name
    group pw.gid
    cwd pw.dir
    environment "HOME" => pw.dir
    code <<-EOC
      curl -L get.rvm.io | bash -s stable
    EOC
    creates "#{pw.dir}/.rvm/bin/rvm"
  end

  bash "setup rvm" do
    user pw.name
    group pw.gid
    cwd pw.dir
    flags "-e"
    environment "HOME" => pw.dir
    code <<-EOC
      echo "source $HOME/.rvm/scripts/rvm" >> ~/.bash_profile
    EOC
    not_if "cat #{pw.dir}/.bash_profile |grep rvm"
  end

end

