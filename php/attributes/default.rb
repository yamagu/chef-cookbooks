lib_dir = kernel['machine'] =~ /x86_64/ ? 'lib64' : 'lib'

case node["platform"]
when "centos", "redhat", "fedora", "scientific", "amazon"
  default['php']['conf_dir']      = '/etc'
  default['php']['ext_conf_dir']  = '/etc/php.d'
  default['php']['fpm_user']      = 'nobody'
  default['php']['fpm_group']     = 'nobody'
  default['php']['ext_dir']       = "/usr/#{lib_dir}/php/modules"
end

default['php']['version'] = ""
default['php']['packages'] = %w{ php php-devel php-cli php-common php-mbstring php-process php-devel php-curl php-xml php-mcrypt php-mysql php-pdo php-gd }
default['php']['memory_limit'] = "128M"

if node['php']['env'] == "dev"
  default['php']['error_reporting'] = "E_ALL | E_STRICT"
  default['php']['display_errors']  = "On"
else
  default['php']['error_reporting'] = "E_ALL & ~E_NOTICE & ~E_DEPRECATED"
  default['php']['display_errors']  = "Off"
end
default['php']['timezone'] = "Asia/Tokyo"
default['php']['default_charset'] = "UTF-8"
