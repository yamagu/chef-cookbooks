major = node['platform_version'].to_i

template "/etc/yum.repos.d/remi.repo" do
  source "remi.repo.erb"
  mode "644"
  owner "root"
  group "root"
  variables({
    :releasever => major,
    :enabled => 0
  })
end

