default['nrpe']['allowed_hosts'] = "127.0.0.1"
default['nrpe']['dont_blame_nrpe'] = 1

filesystems = []
node["filesystem"].each do |key, value|
  if value["percent_used"]
    filesystems.push(key)
  end
end
default['nrpe']['check_disk'] = {"enable" => true , "filesystems" => filesystems }

default['nrpe']['check_load'] = {
  "enable" => true ,
  "w" => "#{node['cpu']['total'] * 4},#{node['cpu']['total'] * 2},#{node['cpu']['total'] * 1}",
  "c" => "#{node['cpu']['total'] * 5},#{node['cpu']['total'] * 4},#{node['cpu']['total'] * 2}"
}

default['nrpe']['check_cpu'] = {"enable" => true }
default['nrpe']['check_mem'] = {"enable" => true }
default['nrpe']['check_http'] = {"enable" => true, "host" => "localhost" }
default['nrpe']['check_smtp'] = {"enable" => true, "host" => "localhost" }
default['nrpe']['check_pop'] = {"enable" => true, "host" => "localhost" }

