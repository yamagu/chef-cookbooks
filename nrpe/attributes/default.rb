if node[:platform] == "amazon"
  default['nrpe']['yumopt'] = ""
else
  default['nrpe']['yumopt'] = "--enablerepo=epel"
end


default['nrpe']['allowed_hosts'] = "127.0.0.1"
default['nrpe']['dont_blame_nrpe'] = 1

filesystems = []
node["filesystem"].each do |key, value|
  if value["percent_used"] && key.index("/") == 0
    filesystems.push(key)
  end
end
default['nrpe']['check_disk'] = {"enable" => true , "filesystems" => filesystems }
default['nrpe']['check_disk_busy'] = {"enable" => true , "filesystems" => filesystems }

default['nrpe']['check_load'] = {
  "enable" => true ,
  "w" => "#{node['cpu']['total'] * 4},#{node['cpu']['total'] * 2},#{node['cpu']['total'] * 1}",
  "c" => "#{node['cpu']['total'] * 5},#{node['cpu']['total'] * 4},#{node['cpu']['total'] * 2}"
}

default['nrpe']['check_cpu']   = {"enable" => true }
default['nrpe']['check_mem']   = {"enable" => true }
default['nrpe']['check_http']  = {"enable" => true, "host" => "localhost" }
default['nrpe']['check_ssl_cert']  = {"enable" => false, "host" => "example.com", "day" => 30 }
default['nrpe']['check_smtp']  = {"enable" => true, "host" => "localhost", "port" => 25 }
default['nrpe']['check_pop']   = {"enable" => true, "host" => "localhost", "port" => 110 }
default['nrpe']['check_ssh']   = {"enable" => true, "host" => "localhost", "port" => 22 }
default['nrpe']['check_mysql'] = {"enable" => true, "host" => "localhost", "port" => 3306, "user" => "monitor" }
default['nrpe']['check_ntp_peer'] = {"enable" => true, "host" => "ntp.nict.jp" }

