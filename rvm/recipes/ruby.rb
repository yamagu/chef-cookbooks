node[:rvm][:users].each do |user|
  pw = Etc.getpwnam(user['name'])
  bash "install ruby" do
    user pw.name
    group pw.gid
    cwd pw.dir
    flags "-e"
    environment "HOME" => pw.dir
    code <<-EOC
      source #{pw.dir}/.bash_profile
      rvm install #{user['version']}
    EOC
    not_if "source #{pw.dir}/.bash_profile;rvm list |grep #{user['version']}", :user => pw.name, :environment => {"HOME" => pw.dir}
  end

  bash "use ruby and default" do
    user pw.name
    group pw.gid
    cwd pw.dir
    flags "-e"
    environment "HOME" => pw.dir
    code <<-EOC
      source #{pw.dir}/.bash_profile
      rvm use #{user['version']} --default
    EOC
    not_if "source #{pw.dir}/.bash_profile;rvm list |grep #{user['version']} |grep =*", :user => pw.name, :environment => {"HOME" => pw.dir}
  end

  template "#{pw.dir}/.gemrc" do
    source "gemrc.erb"
    owner pw.name
    group pw.gid
    mode "0644"
  end
end
