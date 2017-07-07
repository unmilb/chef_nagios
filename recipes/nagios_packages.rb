package "Install Nagios" do
 case node[:platform]
 when 'redhat', 'centos'
   package_name %w(httpd php php-mysql gcc glibc glibc-common gd gd-devel make net-snmp openssl-devel xinetd unzip)
 when 'ubuntu', 'debian'
   package_name %w(apache2 build-essential libgd2-xpm-dev openssl libssl-dev xinetd apache2-utils unzip)
 end
 action :install
end

