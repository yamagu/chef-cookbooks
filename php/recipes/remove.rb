node['php']['packages'].each do |name|
  yum_package name do
    action :remove
  end
end
