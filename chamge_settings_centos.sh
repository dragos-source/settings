echo "-------------------------------------------"
echo "Welcome in Configuration Wizard For CentOS "
echo "This will help you to set the Hostname, IP address,"
echo "Gateway and DNS server" 
echo "==========================================="
echo "script made by Dragos Rimis"
echo "==========================================="
#Ask for new hostname $newhost
	#Imput section
#Inserting Hostname
read -p "Enter new hostname: "
newhostname=$REPLY
#inserting IP Address
read -p "Enter IP address: "
ipaddress=$REPLY
#inserting subnet
read -p "Enter Subnetmask: "
subnet=$REPLY
#inserting gateway
read -p "Enter Gateway: "
gateway=$REPLY
#inserting Primary DNS
read -p "Enter Primary DNS: "
dns1=$REPLY
#inserting Secondary DNS
read -p "Enter Secondary DNS: "
dns2=$REPLY
#Changing the hostname
echo
echo "Changing Hostname..."
hostnamectl set-hostname $newhostname
# Retrieves the NIC information
nic=`ifconfig | awk 'NR==1{print substr($1, 1, length($1)-1)}'`

#IP Change
echo
echo "Changing IP address..."
# Creates a backup of the network configuration file
cp /etc/sysconfig/network-scripts/ifcfg-$nic /etc/sysconfig/network-scripts/ifcfg-$nic.bk_`date +%Y%m%d%H%M`
#Disable DHCP
sed -i '/dhcp/s/^/#/g' /etc/sysconfig/network-scripts/ifcfg-$nic

#Update Configuration File
echo
echo 'BOOTPROTO=static' >> /etc/sysconfig/network-scripts/ifcfg-$nic
echo 'IPADDR="'$ipaddress'"' >> /etc/sysconfig/network-scripts/ifcfg-$nic
echo 'NETMASK="'$subnet'"' >> /etc/sysconfig/network-scripts/ifcfg-$nic
echo 'GATEWAY="'$gateway'"' >> /etc/sysconfig/network-scripts/ifcfg-$nic
echo 'DNS1="'$dns1'"' >> /etc/sysconfig/network-scripts/ifcfg-$nic
echo 'DNS2="'$dns2'"' >> /etc/sysconfig/network-scripts/ifcfg-$nic
echo 'HOSTNAME="'$newhostname'"' >> /etc/sysconfig/network-scripts/ifcfg-$nic
#apply network configuration
systemctl restart NetworkManager.service
/etc/init.d/network restart
echo "==========================="
echo "The setting was applied. To see the changed name please logoff from root and login back"
echo


