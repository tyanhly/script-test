#!/bin/bash
# Bash Menu Script Example


PS3="Enter your choice :"
select choice in \
"all - Run all: dhcp, tftp, nfs" \
"network - Configure Network For Server" \
"dhcp - Install DHCP" \
"tftp - Install TFTP" \
"nfs - Install NFS" \
"kernel - Setup kernel" \
"restart - Restart DHCP TFTP NFS" \
"capture - Capture" \
"vcnn - View TCP Connections " \
"clients - Show all clients" \
"test-dhcp - Test DHCP" \
"test-tftp - Test TFTP" \
"test-nfs - Test NFS" \
"h - Help" \
"q - Quit"; do
case $REPLY in
    1|all) echo "$choice"; 
        source dhcp.sh;
        source tftp.sh;
        source nfs.sh;;

    2|network) echo "$choice"; 
        source network.sh;;

    3|dhcp) echo "$choice";
        source dhcp.sh;;

    4|tptp) echo "$choice";
        source tftp.sh;;

    5|nfs) echo "$choice";
        source nfs.sh;;

    6|kernel)
        cat kisssysctl.conf > /etc/sysctl.conf;
        sysctl -p;;

    7|restart) echo "$choice";
        service isc-dhcp-server restart;
        stop tftpd-hpa;
        start tftpd-hpa;
        service nfs-kernel-server restart;;
    
    8|capture) echo "$choice"
        DATE=`date +%Y%m%d_%H%M%S`
        fbgrab -c 1 s1_$DATE.png;
        fbgrab -c 2 s2_$DATE.png;
        fbgrab -c 3 s3_$DATE.png;
        fbgrab -c 4 s4_$DATE.png;
        fbgrab -c 5 s5_$DATE.png;
        fbgrab -c 6 s6_$DATE.png;;
        

    9|vcnn) echo "$choice";
        watch -n 1 'ss -s';;
    
    10|clients) echo "$choice";
        ./tools/main.php ips;;
    11|testDhcp) echo "$choice";
        source config.sh;
        dhclient -nw -v $PUB_IP;;
   
    12|testTftp) echo "$choice";
        apt-get install tftp;
        source config.sh;
        echo get pxelinux.0 | tftp $PUB_IP ;;

    13|testNfs) echo "$choice";
        apt-get install nfs-common portmap;
        source config.sh;
        echo "mount $PUB_IP/nfsroot /tmp/nfsroot ";
        echo "showmount -e $PUB_IP";
        showmount -e $PUB_IP;;


    14|h) echo "$choice";
        source help.sh;;

    15|q) echo "See you next time"; break;;

    *) echo "Wrong choice!";;
esac
done
