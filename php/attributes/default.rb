lib_dir = kernel['machine'] =~ /x86_64/ ? 'lib64' : 'lib'

case node["platform"]
when "centos", "redhat", "fedora", "scientific", "amazon"
  default['php']['conf_dir']      = '/etc'
  default['php']['ext_conf_dir']  = '/etc/php.d'
  default['php']['fpm_user']      = 'nobody'
  default['php']['fpm_group']     = 'nobody'
  default['php']['ext_dir']       = "/usr/#{lib_dir}/php/modules"
end

default['php']['version'] = "5.3.15-1.el6.remi"
default['php']['packages'] = %w{ php php-devel php-cli php-common php-mbstring php-curl php-xml php-mcrypt php-mysql php-pdo php-gd }
