#!/bin/bash
# install_chef-solo.sh

yum install -y epel-release &&
yum install -y gcc gcc-c++ make git &&
rpm -Uvh http://rpm.aegisco.com/aegisco/rhel/aegisco-rhel.rpm &&
perl -p -i.bak -e 's/\$releasever/6/g' /etc/yum.repos.d/aegisco.repo &&
yum install -y ruby ruby-shadow ruby-ri ruby-rdoc ruby-devel gecode gecode-devel rubygems &&
gem install chef --no-rdoc --no-ri &&
gem install rake rake-compiler rspec --no-ri --no-rdoc &&
gem install knife-solo --no-ri --no-rdoc

knife configure -r . --defaults &&
knife kitchen /etc/chef

mkdir /var/chef-solo &&
cat > /etc/chef/solo.rb <<EOF
file_cache_path '/var/chef-solo'
cookbook_path   '/etc/chef/cookbooks'
json_attribs    '/etc/chef/node.json'
EOF


cat > /etc/chef/node.json <<EOS
{
  "screen": {
    "users": [ "root", "ec2-user" ]
  },
  "vim": {
    "users": [ "root", "ec2-user" ]
  },
  "run_list": [ "recipe[locale]"
  , "recipe[screen]"
  , "recipe[ntp]"
  , "recipe[vim]" ]
}
EOS

# chef-solo -c /etc/chef/solo.rb 
