
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
