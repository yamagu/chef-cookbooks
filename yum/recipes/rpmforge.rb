
rpm_file = "rpmforge-release-0.5.2-2.el#{node['yum']['releasever']}.rf.x86_64.rpm"

remote_file "#{Chef::Config[:file_cache_path]}/#{rpm_file}" do
  source "http://pkgs.repoforge.org/rpmforge-release/#{rpm_file}"
  not_if "rpm -qa | grep rpmforge-release"
  notifies :install, "rpm_package[rpmforge]", :immediately
end


rpm_package "rpmforge" do
  source "#{Chef::Config[:file_cache_path]}/#{rpm_file}"
  only_if {::File.exists?("#{Chef::Config[:file_cache_path]}/#{rpm_file}")}
  action :nothing
end
