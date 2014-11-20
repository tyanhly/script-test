DEST=/mnt/squashfs
mkdir -p /mnt/live 2> /dev/null
sudo mksquashfs ${DEST} /mnt/live/filesystem.squashfs -noappend -always-use-fragments

