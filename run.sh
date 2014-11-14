#!/bin/bash
# Bash Menu Script Example


PS3="Enter your choice :"
select choice in "Run all (a)" "Configure Network" "Install DHCP" "Install TFTP" "Install NFS" "Setup tools" "Help (h)" "Quit (q)"; do
case $REPLY in
    1|a) echo "$choice"; 
        source network.sh;
        source dhcp.sh;
        source tftp.sh;
        source nfs.sh;;

    2) echo "$choice"; 
        source network.sh;;

    3) echo "$choice";
        source dhcp.sh;;

    4) echo "$choice";
        source tftp.sh;;

    5) echo "$choice";
        source nfs.sh;;

    6) echo "$choice";
        source setup-tool.sh;;

    7|h) echo "$choice";
        source help.sh;;

    8|q) echo "See you next time";break;;

    *) echo "Wrong choice!";;
esac
done
