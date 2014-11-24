#!/bin/bash
for i in {30..70}
do
#et "ip=$i+200"
let "ip=$i"
echo "ifconfig tungly2:$i 192.168.$ip.13"
ifconfig tungly2:$i 192.168.$ip.13

done


# ifconfig tungly2 192.168.30.226
# ifconfig tungly2:0 192.168.30.227
# ifconfig tungly2:1 192.168.30.228
# ifconfig tungly2:2 192.168.30.229
# ifconfig tungly2:3 192.168.30.230
# ifconfig tungly2:4 192.168.30.231
# ifconfig tungly2:5 192.168.30.232
# ifconfig tungly2:6 192.168.30.233
