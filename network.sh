#!/bin/bash
source config.sh
echo "
##############################
# NETWORK
##############################"

echo "ifconfig $PRI_INTERFACE $PRI_IP netmask $PRI_NETMASK"
ifconfig $PRI_INTERFACE $PRI_IP netmask $PRI_NETMASK

i=0
for ((MID=$PRE_IP_MID_FIRST; $PRI_IP_MID_END>=MID; MID++,i++))
do
  #let "i=$i+1"
  echo "ifconfig $PRI_INTERFACE:$i $PRI_IP_PREFIX.$MID.$PRI_IP_SUBFIX"
  ifconfig $PRI_INTERFACE:$i $PRI_IP_PREFIX.$MID.$PRI_IP_SUBFIX
done

#route del default
#ip route add default via $PRI_IP