echo "`ifconfig | grep "inet addr" | sed -e "y/:/ /" | awk '{print $3}'`" > /tmp/kiss_ips.data

lastConnections=`cat /tmp/ip_connections.data || touch /tmp/ip_connections.data`
echo "" > /tmp/kiss_ip_connections.data
echo "" > /tmp/kiss_ip_connections.show
currentTime=`date +%s`
while read line; do
   amount=`ss -t | grep $line -c`   
   rate=0
   if [ -n "$lastConnections" ]; then
	   record=`grep $line <<< $lastConnections`
	   lastAmount=`awk '{print $2}' <<< $record`
	   lastTime=`awk '{print $3}' <<< $record`
	   if [ -n "$lastAmount$lastTime" ]; then
           rate=$((($amount-$lastAmount)/($currentTime - $lastTime)))
       fi
   fi

   echo "$line $amount $currentTime" >> /tmp/kiss_ip_connections.data   
   printf '%-20s %-10s %-10s\n' $line $amount $rate >> /tmp/kiss_ip_connections.show   
done < /tmp/kiss_ips.data
printf '%-20s %-10s %-10s\n' "IP" "Amount" "Rate"
tail -n 40 /tmp/kiss_ip_connections.show
