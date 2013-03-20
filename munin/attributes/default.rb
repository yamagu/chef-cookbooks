default['munin']['version'] = nil
default['munin']['options'] = "--enablerepo=epel"
default['munin']['ssl_require'] = false
default['munin']['admin_user'] = "muninadmin"
default['munin']['admin_password'] = "password"
default['munin']['allow_hosts'] = "all"
default['munin']['nodes'] = [{"host" => "localhost", "address" => "127.0.0.1"}]
