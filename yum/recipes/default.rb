#
# Cookbook Name:: yum
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if node["yum"]["releasever"] == 6
  package "yum-plugin-fastestmirror"
  package "yum-plugin-priorities"
else
  package "yum-fastestmirror"
  package "yum-priorities"
end


case node[:platform]
when "scientific"
  template "/etc/sysconfig/yum-autoupdate" do
    source "yum-autoupdate.erb"
    mode "644"
    owner "root"
    group "root"
    variables({
      :enabled => "false"
    })
  end

  template "/etc/yum.repos.d/sl.repo" do
    source "sl.repo.erb"
    mode "644"
    owner "root"
    group "root"
    variables({
      :mirrorlist_base     => "http://ftp.scientificlinux.org/linux/scientific/mirrorlist/sl-base-6x.txt",
      :mirrorlist_security => "http://ftp.scientificlinux.org/linux/scientific/mirrorlist/sl-security-6x.txt"
    })
  end
end
