#
# Cookbook Name:: screen
# Recipe:: default
#
# Copyright 2012, Example Com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
package "screen" do
    action :install
end

require 'etc'
node[:screen][:users].each do |user|
  if user.length > 0
    pw = Etc.getpwnam(user)
    rcfile = "#{pw.dir}/.screenrc"

    template rcfile do
      source "screenrc.erb"
      owner pw.name
      group Etc.getgrgid(pw.gid).name
      mode "0644"
    end
  end
end

