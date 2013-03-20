
git "/usr/share/munin/contrib" do
  repository "git://github.com/munin-monitoring/contrib.git"
  reference "master"
  action :sync
end
