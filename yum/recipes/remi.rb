
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
  notifies :run, "execute[update_releasever]", :immediately
end

execute "update_releasever" do
  command "perl -p -i.bak -e 's/\\$releasever/#{major}/' /etc/yum.repos.d/remi.repo"
  action :nothing
end

file "remi-cleanup" do
  path "#{Chef::Config[:file_cache_path]}/remi-release-#{major}.rpm"
  action :delete
end


