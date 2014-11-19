DEST=/var/squashfs
mkdir -p /live 2> /dev/null
sudo mksquashfs ${DEST} /live/filesystem.squashfs -noappend -always-use-fragments

