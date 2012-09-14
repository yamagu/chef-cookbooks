
bash "install_xdebug" do
  user "root"
  code "yum install -y --enablerepo=remi php-pecl-xdebug"
end
