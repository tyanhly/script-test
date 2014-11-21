#!/bin/bash 

while [ 1 ]; do
clear
echo -n -e "\E[01;32m"
echo "============ Connections ========================"
echo -n -e "\E[01;37m"
source connections.sh
echo -n -e "\E[01;31m"
echo "============ Command Center ====================="
echo -n -e "\E[01;37m"
cat /tmp/kiss_client_command.sh | tail -n 4
echo -n -e "\E[01;31m"
echo "============ Command Center Output =============="
echo -n -e "\E[01;37m"
cat /tmp/kiss_client_command.output | tail -n 10
sleep 2
done
