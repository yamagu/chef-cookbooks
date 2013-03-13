directory "#{node['httpd']['compress_log']['script_dir']}" do
 owner "root"
 group "root"
 mode "0755"
end

script_name = "#{node['httpd']['compress_log']['script_dir']}/httpd_compress_log.sh"

template script_name do
  source "httpd_compress_log.sh.erb"
  mode 0755
  owner "root"
  group "root"
end

cron = node['httpd']['compress_log']['cron']

if cron['enable']
  cron "httpd-compress-log" do
    user "root"
    minute cron['minute']
    hour cron['hour']
    command "sh #{script_name}"
  end
end
