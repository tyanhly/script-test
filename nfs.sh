#!/bin/bash

source config.sh


echo "
##############################
# NFS
##############################
"
apt-get -y install nfs-kernel-server

mkdir /nfsroot/live -p
cp $PUB_NFS_OS_FILE /nfsroot/live
cat <<EOF >/etc/exports
/nfsroot  $PUB_SUBNET/$PUB_NFS_BITMASK(fsid=0,ro,no_root_squash,insecure,no_subtree_check)
EOF

exportfs -a

service nfs-kernel-server restart

