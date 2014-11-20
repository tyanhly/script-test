#!/bin/bash
# Bash Menu Script Example


PS3="Enter your choice :"
select choice in "all - Run all: init, dhcp, tftp, nfs, tools" \
"network - Configure Network For Server" \
"dhcp - Install DHCP" \
"tftp - Install TFTP" \
"nfs - Install NFS" \
"tools - Setup tools" \
"kernel - Setup kernel" \
"restart - Restart DHCP TFTP NFS" \
"setupClients - Setup Clients" \
"capture - Capture" \
"vcnn - View TCP Connections " \
"clients - Show all clients" \
"h - Help" \
"q - Quit"; do
case $REPLY in
    1|all) echo "$choice"; 
        source init.sh;
        source dhcp.sh;
        source tftp.sh;
        source nfs.sh;;
#        source setup_tool.sh;;

    2|network) echo "$choice"; 
        source network.sh;;

    3|dhcp) echo "$choice";
        source dhcp.sh;;

    4|tptp) echo "$choice";
        source tftp.sh;;

    5|nfs) echo "$choice";
        source nfs.sh;;

    6|tools) echo "$choice";
        source setup-tool.sh;;

    7|kernel)
        cat kisssysctl.conf > /etc/sysctl.conf;
        sysctl -p;;

    8|restart) echo "$choice";
        service isc-dhcp-server restart;
        stop tftpd-hpa;
        start tftpd-hpa;
        service nfs-kernel-server restart;;
    
    9|setupClients) echo "$choice"
        source setup_clients.sh;;

    10|capture) echo "$choice"
        DATE=`date +%Y%m%d_%H%M%S`
        fbgrab -c 1 s1_$DATE.png;
        fbgrab -c 2 s2_$DATE.png;
        fbgrab -c 3 s3_$DATE.png;
        fbgrab -c 4 s4_$DATE.png;
        fbgrab -c 5 s5_$DATE.png;
        fbgrab -c 6 s6_$DATE.png;;
        

    11|vcnn) echo "$choice";
        watch -n 1 'ss -s';;
    
    12|clients) echo "$choice";
        ./tools/main.php ips;;


    13|h) echo "$choice";
        source help.sh;;

    14|q) echo "See you next time"; break;;

    *) echo "Wrong choice!";;
esac
done
