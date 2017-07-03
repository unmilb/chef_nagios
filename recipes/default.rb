#
# Cookbook:: nagios
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

package "Install Nagios" do
 case node[:platform]
 when 'redhat', 'centos'
   package_name %w(gcc glibc glibc-common gd gd-devel make net-snmp openssl-devel xinetd unzip)
 when 'ubuntu', 'debian'
   package_name %w(build-essential libgd2-xpm-dev openssl libssl-dev xinetd apache2-utils unzip)
 end
 action :install
end


user 'nagios' do
  action :create
end


#group 'nagcmd' do
# action :create
#end

#group 'nagcmd' do
# members 'nagios'
# append true
# action :modify
#end


#remote_file '/root/Downloads/nagios-4.3.2.tar.gz' do
# source 'https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.3.2.tar.gz'
# action :create
#end

execute 'nagios-4.3.2.tar.gz' do
 command 'tar -zxvf /root/Downloads/nagios-4.3.2.tar.gz'
 cwd '/root/Downloads/'
# not_if { File.exists?("/file/contained/in/tar/here") }
end

execute './configure --with-command-group=nagcmd' do
 command '/root/Downloads/nagios-4.3.2/configure --with-command-group=nagcmd'
end
