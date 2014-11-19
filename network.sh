#!/bin/bash
source config.sh
echo "
##############################
# NETWORK
##############################"
echo "Acquire::http::proxy \"http://$APT_PROXY_IP:3142\";" > /etc/apt/apt.conf;
echo "ifconfig $PUB_INTERFACE  $PUB_IP netmask $PUB_NETMASK"
ifconfig $PUB_INTERFACE $PUB_IP netmask $PUB_NETMASK
echo "ifconfig $PRI_INTERFACE $PRI_IP netmask $PRI_NETMASK"
ifconfig $PRI_INTERFACE $PRI_IP netmask $PRI_NETMASK
#apt-get -y update

$i=0
for $IP_SUBFIX in {$SERVER_IP_FIRST..$_SERVER_IP_END}
do
let "i=$i+1"
echo "ifconfig $PRI_INTERFACE:$i $SERVER_IP_PREFIX.$IP_SUBFIX"

ifconfig $PRI_INTERFACE:$i $SERVER_IP_PREFIX.$IP_SUBFIX
done