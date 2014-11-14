#!/bin/bash

source config.sh

echo "
##############################
# NETWORK
##############################"
echo "Acquire::http::proxy \"http://$APT_PROXY_IP:3142\";" > /etc/apt/apt.conf;
echo "ifconfig eth0 $PUB_IP netmask $PUB_NETMASK"
ifconfig eth0 $PUB_IP netmask $PUB_NETMASK
echo "ifconfig eth1 $PRI_IP netmask $PRI_NETMASK"
ifconfig eth1 $PRI_IP netmask $PRI_NETMASK
#apt-get -y update

