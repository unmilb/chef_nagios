#
# Cookbook:: nagios Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
package "Install Nagios" do
 case node[:platform]
 when 'redhat', 'centos'
   package_name %w(httpd php php-mysql gcc glibc glibc-common gd gd-devel make net-snmp openssl-devel xinetd unzip)
 when 'ubuntu', 'debian'
   package_name %w(apache2 build-essential libgd2-xpm-dev openssl libssl-dev xinetd apache2-utils unzip)
 end
 action :install 
end 

user 'nagios' do
  action :create 
end 

group 'nagcmd' do
 action :create 
end 

group 'nagcmd' do
 members 'nagios'
 append true
 action :modify 
end 

remote_file '/root/Downloads/nagios-4.3.2.tar.gz' do
 source 'https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.3.2.tar.gz'
 action :create 
end 

execute 'nagios-4.3.2.tar.gz' do
 command 'tar -zxvf /root/Downloads/nagios-4.3.2.tar.gz'
 cwd '/root/Downloads/'
# not_if { File.exists?("/root/Downloads/nagios-4.3.2.tar.gz") } 
end 

execute './configure --with-command-group=nagcmd' do
 command './configure --with-command-group=nagcmd && make all && make install && make install-commandmode'
 cwd '/root/Downloads/nagios-4.3.2/' 
end 

#execute 'make all' do
# command 'make all'
#end 

#execute 'sudo make install && sudo make install-commandmode' do
# command 'make install && make install-commandmode'
# user 'root' 
#end 

execute 'install init' do
 command 'make install-init'
 user 'root' 
 cwd '/root/Downloads/nagios-4.3.2/'
end 

execute 'config files' do
 command 'make install-config'
 user 'root' 
 cwd '/root/Downloads/nagios-4.3.2/'
end

## Needs apache
execute 'webconf files' do
 command 'make install-webconf'
 cwd '/root/Downloads/nagios-4.3.2/'
 user 'root' 
end 

group 'nagcmd' do
 members 'apache'
 append true
 action :modify 
end 

remote_file '/root/Downloads/nagios-plugins-2.2.1.tar.gz' do
 source 'http://nagios-plugins.org/download/nagios-plugins-2.2.1.tar.gz'
 action :create 
end 

execute 'nagios-plugins-2.2.1.tar.gz' do
 cwd '/root/Downloads/'
 command 'tar -zxvf nagios-plugins-2.2.1.tar.gz &&
 pwd &&
 cd /root/Downloads/nagios-plugins-2.2.1 &&
 pwd &&
 ./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl &&
 pwd && make && make install'
 cwd '/root/Downloads/'
# not_if { File.exists?("/file/contained/in/tar/here") }
end 

remote_file '/root/Downloads/nrpe-3.1.1.tar.gz' do
 source 'https://excellmedia.dl.sourceforge.net/project/nagios/nrpe-3.x/nrpe-3.1.1/nrpe-3.1.1.tar.gz'
 action :create 
end 

execute 'nrpe-3.1.1.tar.gz' do
 cwd '/root/Downloads/'
 command 'tar -zxvf nrpe-3.1.1.tar.gz &&
 pwd &&
 cd /root/Downloads/nrpe-3.1.1 &&
 ./configure --enable-command-args --with-nagios-user=nagios --with-nagios-group=nagios --with-ssl=/usr/bin/openssl --with-ssl-lib=/usr/lib/x86_64-linux-gnu '
end 

execute 'Install' do
 cwd '/root/Downloads/nrpe-3.1.1'
 command 'make all && make install'
end

execute 'Xinetd' do
 cwd '/root/Downloads/nrpe-3.1.1'
 command 'make install-xinetd && make install-daemon-config'
end

execute 'Instal daemon' do
 cwd '/root/Downloads/nrpe-3.1.1'
 command 'make install-daemon-config'
end

execute 'install config' do
 cwd '/root/Downloads/nrpe-3.1.1'
 command ' make install-config'
end

execute 'Create service' do
 cwd '/root/Downloads/nrpe-3.1.1'
 command 'make service'
end

execute 'make' do
 command "echo >> /etc/services && echo '# Nagios services' >> /etc/services"
end

execute 'nrpe services' do
 command "echo 'nrpe 5666/tcp' >> /etc/services "
end

execute 'install init' do
 command 'make install-init && systemctl enable nrpe.service'
end

