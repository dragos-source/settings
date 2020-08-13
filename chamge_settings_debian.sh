echo "-------------------------------------------"
echo "Welcome in Configuration Wizard For Debian "
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
cp /etc/network/interfaces /etc/network/interfaces.bk_`date +%Y%m%d%H%M`

#Disable DHCP
sed -i '/dhcp/s/^/#/g' /etc/network/interfaces

#Update Configuration File
echo
echo 'iface '$nic' inet static' >> /etc/network/interfaces
echo 'address '$ipaddress'' >> /etc/network/interfaces
echo 'netmask '$subnet'' >> /etc/network/interfaces
echo 'gateway '$gateway'' >> /etc/network/interfaces
echo 'dns-nameservers '$dns1' '$dns2'' >> /etc/network/interfaces

#apply network configuration
systemctl restart networking
ifup $nic

echo "==========================="
echo "The settings was applied. To see the changed name please logoff from root and login back"
echo


