#!/bin/bash

source config.sh

echo "
##############################
# DHCP
##############################"
apt-get -y install isc-dhcp-server
cat <<EOF >/etc/dhcp/dhcpd.conf
allow booting;
allow bootp;
class "allow" {
   match if substring(hardware, 1,3) = 08:00:27;
}

subnet $PRI_SUBNET netmask $PRI_NETMASK {
  pool{
    allow members of "allow";
    authoritative;
    range $PRI_RANGE;
    option broadcast-address $PRI_BROADCAST;
    option routers $PRI_IP;
    option domain-name-servers $PRI_IP;
    filename "pxelinux.0";
  }
}

EOF
service isc-dhcp-server restart

