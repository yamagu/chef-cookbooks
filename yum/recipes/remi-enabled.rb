
include_recipe "yum::epel"

major = node['platform_version'].to_i

remote_file "#{Chef::Config[:file_cache_path]}/remi-release-#{major}.rpm" do
  source "http://rpms.famillecollet.com/enterprise/remi-release-#{major}.rpm"
  not_if "rpm -qa | grep remi-release"
  notifies :install, "rpm_package[remi]", :immediately
end


rpm_package "remi" do
  source "#{Chef::Config[:file_cache_path]}/remi-release-#{major}.rpm"
  only_if {::File.exists?("#{Chef::Config[:file_cache_path]}/remi-release-#{major}.rpm")}
  action :nothing
end

template "/etc/yum.repos.d/remi.repo" do
  source "remi.repo.erb"
  mode "644"
  owner "root"
  group "root"
  variables({
    :releasever => major,
    :priority => 1,
    :enabled => 1
  })
end

file "remi-cleanup" do
  path "#{Chef::Config[:file_cache_path]}/remi-release-#{major}.rpm"
  action :delete
end


