#!/bin/bash
interfaces=`ls /sys/class/net`

i1=`awk '{print $1}' <<< $interfaces`
i2=`awk '{print $2}' <<< $interfaces`
i3=`awk '{print $3}' <<< $interfaces`

#ifconfig $i1 down
#ifconfig $i2 down
#ifconfig $i3 down

if [ -n "$i1" ]; then
    ip link set $i1 up

fi
if [ -n "$i2" ]; then
    ip link set $i2 up
fi
if [ -n "$i3" ]; then
    ip link set $i3 up
fi
