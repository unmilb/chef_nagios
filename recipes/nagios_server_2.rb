
execute 'nrpe services' do
 command "echo 'nrpe 5666/tcp' >> /etc/services "
end

execute 'install init' do
 command 'make install-init && systemctl enable nrpe.service'
end

