source config.sh
echo "
##############################
# NETWORK
##############################"
echo "#Acquire::http::proxy \"http://$APT_PROXY_IP:3142\";" > /etc/apt/apt.conf;

echo "ifconfig $PUB_INTERFACE  $PUB_IP netmask $PUB_NETMASK"
ifconfig $PUB_INTERFACE $PUB_IP netmask $PUB_NETMASK
ip route add default via $PUB_IP
#ip route add default via $PUB_IP netmask 255.255.0.0 gw $PUB_GATEWAY
#route add default gw $PUB_GATEWAY
