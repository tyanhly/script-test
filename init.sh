source config.sh
echo "
##############################
# NETWORK
##############################"
echo "#Acquire::http::proxy \"http://$APT_PROXY_IP:3142\";" > /etc/apt/apt.conf;
echo "nameserver 8.8.8.8" >> /etc/resolv.conf


ip link add $PRI_INTERFACE type veth peer name $PRI_INTERFACE-bride

echo "ifconfig $PRI_INTERFACE $PRI_IP netmask $PRI_NETMASK"
ifconfig $PRI_INTERFACE $PRI_IP netmask $PRI_NETMASK


echo "ifconfig $PUB_INTERFACE  $PUB_IP netmask $PUB_NETMASK"
ifconfig $PUB_INTERFACE $PUB_IP netmask $PUB_NETMASK

git config --global user.name "tyanhly"
git config --global user.email tyanhly@example.com
git config --global push.default simple

route del default
ip route add default via $PUB_IP
#ip route add default via $PUB_IP netmask 255.255.0.0 gw $PUB_GATEWAY
#route add default gw $PUB_GATEWAY
