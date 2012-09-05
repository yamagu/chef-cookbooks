
packages = %w[ php-snmp ].map do |name|
  if node['php']['version'].length > 0
    "#{name}-#{node['php']['version']}"
  else
    name
  end
end

bash "install_php" do
  user "root"
  code "yum install -y --enablerepo=remi #{packages.join(' ')}"
end
