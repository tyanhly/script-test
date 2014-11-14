#!/bin/bash

source config.sh

echo "
##############################
# TFTPD
##############################"
apt-get -y install tftpd-hpa syslinux
cat <<EOF >/etc/default/tftpd-hpa
TFTP_USERNAME="tftp"
TFTP_DIRECTORY="/tftpboot"
TFTP_ADDRESS="0.0.0.0:69"
TFTP_OPTIONS="--secure"
EOF
#cp tftpd-hpa /etc/default/tftpd-hpa 
mkdir -p /tftpboot/pxelinux.cfg
cp /usr/lib/syslinux/pxelinux.0 /tftpboot/
cp vmlinuz-3.13.0-39-generic /tftpboot/vmlinuz
cp initrd.img-3.13.0-39-generic /tftpboot/initrd.img
cat <<EOF >/tftpboot/pxelinux.cfg/default
DEFAULT ubuntu
LABEL ubuntu
MENU LABEL ubuntu
KERNEL vmlinuz
APPEND bootfrom=/dev/nfs boot=live root=/dev/nfs initrd=initrd.img nfsroot=$PRI_IP:/nfsroot toram=filesystem.squashfs ip=dhcp ro
EOF

chmod -R 777 /tftpboot/
stop tftpd-hpa
start tftpd-hpa
