default['nagios']['notification_prefix']   = ""
default['nagios']['ssl_require']   = false
default['nagios']['admin_user']     = "nagiosadmin"
default['nagios']['admin_password'] = "password"
default['nagios']['allow_hosts']    = "all"
default['nagios']['contacts']       = [{"name" => "nagiosadmin", "email" => "nagios@localhost"}]

default['nagios']['hostgroups']     = [
  {"hostgroup_name" => "linux-servers", "alias" => "Linux Servers", "members" => ["localhost"]}
]
default['nagios']['hosts']     = [
  {"host_name" => "localhost", "alias" => "localhost", "address" => "127.0.0.1"}
]


default['nagios']['roles'] = [
  {"name" => "all-server",  "members" => ["localhost"]},
  {"name" => "app-server",  "members" => ["localhost"]},
  {"name" => "db-server",   "members" => ["localhost"]},
  {"name" => "smtp-server", "members" => ["localhost"]}
]

default['nagios']['check_disk_sufix'] = [""]
if node[:platform] == "amazon"
  default['nagios']['yumopt'] = ""
else
  default['nagios']['yumopt'] = "--enablerepo=epel"
end
