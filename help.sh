#!/bin/bash

source config.sh


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
    echo "get pxelinux.0" | tftp $PRI_IP
  3. Check nfs
    apt-get -y install nfs-common portmap
    ifconfig tungly $PRI_IP
    showmount -e $PRI_IP
    mount $PRI_IP:/nfsroot /mnt

"
      
