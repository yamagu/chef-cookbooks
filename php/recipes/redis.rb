
bash "install_php_redis" do
  user "root"
  cwd "/usr/local/src"
  code <<-EOH
wget -O phpredis.tar.gz https://github.com/owlient/phpredis/tarball/master &&
tar xvzf phpredis.tar.gz &&
cd owlient-phpredis-90ecd17 &&
phpize &&
./configure &&
make install
  EOH
end

template "/etc/php.d/redis.ini" do
  source "extension.erb"
  mode "644"
  owner "root"
  group "root"
  variables({
    :name => "redis",
    :extension => "redis.so"
  })
end

