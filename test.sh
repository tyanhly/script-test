echo "`ifconfig | grep "inet addr" | sed -e "y/:/ /" | awk '{print $3}'`" > /tmp/ips.dmesg

lastConnections=`cat /tmp/ip_connections.data || touch /tmp/ip_connections.data`
echo "" > /tmp/ip_connections.data
echo "%-20s %-10s %-10s" "IP" "Amount" "Rate" > /tmp/ip_connections.show
currentTime=`date +%s`
while read line; do
   amount=`ss -t | grep $line -c`
   record=`echo "$lastConnections" | grep $line`
   lastAmount=`echo $record | awk '{print $2}'
   lastTime=`echo $record | awk '{print $3}'
   rate=$(($currentTime - $lastTime))
   echo "$line $amount $currentTime" >> /tmp/ip_connections.data   
   printf "%-20s %-10s %-10s" $line $amount $rate >> /tmp/ip_connections.data   
done < /tmp/ips.dmesg
