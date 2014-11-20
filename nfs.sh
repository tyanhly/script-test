#!/bin/bash

source config.sh


echo "
##############################
# NFS
##############################
"
apt-get -y install nfs-kernel-server

mkdir /nfsroot/live -p
cp filesystem.squashfs /nfsroot/live
cat <<EOF >/etc/exports
/nfsroot  $PRI_SUBNET/$PRI_NFS_BITMASK(fsid=0,ro,no_root_squash,insecure,no_subtree_check)
EOF

exportfs -a

service nfs-kernel-server restart

