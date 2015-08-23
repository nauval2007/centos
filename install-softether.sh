
# installing softether
cd 
wget http://www.softether-download.com/files/softether/v4.18-9570-rtm-2015.07.26-tree/Linux/SoftEther_VPN_Server/32bit_-_Intel_x86/softether-vpnserver-v4.18-9570-rtm-2015.07.26-linux-x86-32bit.tar.gz

tar -xvf softether-vpnserver-v4.18-9570-rtm-2015.07.26-linux-x86-32bit.tar.gz

cd vpnserver
make
cp -R * /usr/local/vpnserver/

# wget -O /etc/init.d/vpnserver https://raw.githubusercontent.com/nauval2007/centos/master/vpnserver
# nano /etc/init.d/vpnserver


echo "#!/bin/sh" > /etc/init.d/vpnserver
echo "# chkconfig: 2345 99 01" >> /etc/init.d/vpnserver
echo "# description: SoftEther VPN Server" >> /etc/init.d/vpnserver
echo "DAEMON=/usr/local/vpnserver/vpnserver" >> /etc/init.d/vpnserver
echo "LOCK=/var/lock/subsys/vpnserver" >> /etc/init.d/vpnserver
echo "test -x $DAEMON || exit 0" >> /etc/init.d/vpnserver
echo 'case "$1" in' >> /etc/init.d/vpnserver
echo "start)" >> /etc/init.d/vpnserver
echo "$DAEMON start" >> /etc/init.d/vpnserver
echo "touch $LOCK" >> /etc/init.d/vpnserver
echo ";;" >> /etc/init.d/vpnserver
echo "stop)" >> /etc/init.d/vpnserver
echo "$DAEMON stop" >> /etc/init.d/vpnserver
echo "rm $LOCK" >> /etc/init.d/vpnserver
echo ";;" >> /etc/init.d/vpnserver
echo "restart)" >> /etc/init.d/vpnserver
echo "$DAEMON stop" >> /etc/init.d/vpnserver
echo "sleep 3" >> /etc/init.d/vpnserver
echo "$DAEMON start" >> /etc/init.d/vpnserver
echo ";;" >> /etc/init.d/vpnserver
echo "*)" >> /etc/init.d/vpnserver
echo 'echo "Usage: $0 {start|stop|restart}"' >> /etc/init.d/vpnserver
echo "exit 1" >> /etc/init.d/vpnserver
echo "esac" >> /etc/init.d/vpnserver
echo "exit 0" >> /etc/init.d/vpnserver

chmod 755 /etc/init.d/vpnserver
# debian 7.8 fix, /var/lock link to /run/lock, but it seem deleted on reboot
# create dir every reboot
# echo '@reboot root mkdir /var/lock/subsys' >> /etc/crontab
# unfortune this seem not fast enough
echo '@reboot root mkdir /var/lock/subsys' > /etc/cron.d/vpnserver
echo '@reboot root touch /var/lock/subsys/vpnserver' >> /etc/cron.d/vpnserver
echo '@reboot root /usr/local/vpnserver/vpnserver start' >> /etc/cron.d/vpnserver 

# mkdir /var/locked
mkdir /var/lock/subsys

# creating vpn_server.config
service vpnserver start
service vpnserver stop

# edit/disable port 443/1194
# nano /usr/local/vpnserver/vpn_server.config
sed -i 's/443/444/g' /usr/local/vpnserver/vpn_server.config
sed -i 's/1194/1195/g' /usr/local/vpnserver/vpn_server.config

if [ -f /etc/debian_version ]; then
    DISTRO=Debian
    # debian
	sysv-rc-conf vpnserver on
elif [ -f /etc/redhat-release ]; then
    DISTRO="Red Hat"
    # centos
	# XXX or CentOS or Fedora
	chkconfig –add vpnserver 
fi



echo "Instalasi sukses!"
echo "Silahkan gunakan Softether Server Manager GUI untuk melanjutkan."