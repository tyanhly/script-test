#!/bin/bash
source config.sh
echo "
##############################
# NETWORK
##############################"


i=0
for ((MID=$PUB_IP_MID_FIRST; $PUB_IP_MID_END>=MID; MID++,i++))
do
  #let "i=$i+1"
  echo "ifconfig $PUB_INTERFACE:$i $PUB_IP_PREFIX$MID$PUB_IP_SUBFIX"
  ifconfig $PUB_INTERFACE:$i $PUB_IP_PREFIX$MID$PUB_IP_SUBFIX
done

#route del default
#ip route add default via $PUB_IP
