############## Nagios Core Download and Install #####################################
remote_file '/root/Downloads/nagios-4.3.2.tar.gz' do
 source 'https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.3.2.tar.gz'
 action :create
end

execute 'nagios-4.3.2.tar.gz' do
 command 'tar -zxvf /root/Downloads/nagios-4.3.2.tar.gz'
 cwd '/root/Downloads/'
 not_if { File.exists?("/root/Downloads/nagios-4.3.2") }
end




############## Nagios Plugins Download and Install ################################
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



############## Nagios NRPE Plugin Download and Install ############################
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

