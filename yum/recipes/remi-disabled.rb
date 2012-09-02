major = node['yum']['releasever'].to_i

template "/etc/yum.repos.d/remi.repo" do
  source "remi.repo.erb"
  mode "644"
  owner "root"
  group "root"
  variables({
    :releasever => major,
    :priority => 1,
    :enabled => 0
  })
end

