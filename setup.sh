#!/bin/bash


PRI_SUBNET="10.0.0.0"
PRI_NETMASK="255.255.0.0"
PRI_RANGE="10.0.0.10 10.0.0.254" 
PRI_BROADCAST="10.0.255.255"
PRIVATE_IP="10.0.0.1"
PRI_IP="10.0.0.1"

PUB_NETMASK="255.255.0.0"
PUB_SUBNET="192.168.30.0"
PUBLIC_IP="192.168.30.156"

echo "
##############################
# network
##############################"
echo 'Acquire::http::proxy "http://192.168.120.253:3142/";' > /etc/apt/apt.conf;
echo "ifconfig eth0 $PUBLIC_IP netmask $PUB_NETMASK"
ifconfig eth0 $PUBLIC_IP netmask $PUB_NETMASK
echo "ifconfig eth1 $PRIVATE_IP netmask $PRI_NETMASK"
ifconfig eth1 $PRIVATE_IP netmask $PRI_NETMASK
#apt-get -y update

echo "
##############################
# dhcp
##############################"
apt-get -y install isc-dhcp-server 
cat <<EOF >/etc/dhcp/dhcpd.conf
allow booting;
allow bootp;
class "allow" {
   match if substring(hardware, 1,3) = 08:00:27;
}

subnet $PRI_SUBNET netmask $PRI_NETMASK {
  pool{
    allow members of "allow";
    authoritative;
    range $PRI_RANGE;
    option broadcast-address $PRI_BROADCAST;
    option routers $PRIVATE_IP;
    option domain-name-servers $PRIVATE_IP;
    filename "pxelinux.0";
  }
}

EOF

#cp dhcpd.conf /etc/dhcp/dhcpd.conf 
service isc-dhcp-server restart


echo "
##############################
# tftpd
##############################"
apt-get -y install tftpd-hpa syslinux
cat <<EOF >/etc/default/tftpd-hpa
TFTP_USERNAME="tftp"
TFTP_DIRECTORY="/tftpboot"
TFTP_ADDRESS="0.0.0.0:69"
TFTP_OPTIONS="--secure"
EOF
#cp tftpd-hpa /etc/default/tftpd-hpa 
mkdir -p /tftpboot/pxelinux.cfg
cp /usr/lib/syslinux/pxelinux.0 /tftpboot/
cp vmlinuz-3.13.0-39-generic /tftpboot/vmlinuz
cp initrd.img-3.13.0-39-generic /tftpboot/initrd.img
cat <<EOF >/tftpboot/pxelinux.cfg/default
DEFAULT ubuntu
LABEL ubuntu
MENU LABEL ubuntu
KERNEL vmlinuz
APPEND bootfrom=/dev/nfs boot=live root=/dev/nfs initrd=initrd.img nfsroot=$PRI_IP:/nfsroot toram=filesystem.squashfs ip=dhcp ro
EOF
#cp default /tftpboot/pxelinux.cfg/
chmod -R 777 /tftpboot/
stop tftpd-hpa 
start tftpd-hpa 

echo "
##############################
# nfs
##############################
"
apt-get -y install nfs-kernel-server

mkdir /nfsroot/live -p
cp filesystem.squashfs /nfsroot/live
cat <<EOF >/etc/exports
/nfsroot             $PRI_SUBNET/24(fsid=0,ro,no_root_squash,insecure,no_subtree_check)
EOF
#/nfsroot             $PUB_SUBNET/24(fsid=1,ro,no_root_squash,insecure,no_subtree_check)
#cp exports /etc/exports

exportfs -a

service nfs-kernel-server restart
echo "
##############################
# COMMENT
##############################"
echo "
A. Command
  1. start
     service isc-dhcp-server start
     start tftpd-hpa
     service nfs-kernel-server start

  1. restart
     service isc-dhcp-server restart
     stop tftpd-hpa
     start tftpd-hpa
     service nfs-kernel-server restart
  2. stop
     service isc-dhcp-server stop
     stop tftpd-hpa
     service nfs-kernel-server stop

B. Checking
  1. Check dhcp
    //run machine
  2. Check tftp
    apt-get -y install tftpd
    echo "get pxelinux.0" | tftp $PRIVATE_IP
  3. Check nfs
    apt-get -y install nfs-common portmap
    ifconfig tungly $PRIVATE_IP
    showmount -e $PRIVATE_IP
    mount $PRIVATE_IP:/nfsroot /mnt

"
