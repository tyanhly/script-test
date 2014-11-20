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

subnet $PUB_SUBNET netmask $PUB_NETMASK {
  pool{
    #allow members of "allow";
    authoritative;
    range $PUB_RANGE;
    option broadcast-address $PUB_BROADCAST;
    option routers $PUB_IP;
    option domain-name-servers $PUB_IP;
    filename "pxelinux.0";
  }
}

EOF
service isc-dhcp-server restart

