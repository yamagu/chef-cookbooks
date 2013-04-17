
template "/etc/nginx/conf.d/rails-unicorn.conf" do
  source "rails-unicorn.conf.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :reload, "service[nginx]"
end
