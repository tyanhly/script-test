DEST=/var/squashfs
mkdir -p $DEST 2> /dev/null
sudo rsync -av --delete / ${DEST} --exclude=/lib/live/mount/* --exclude=/mnt/* --exclude=/media/* --exclude=/proc/* --exclude=/tmp/* --exclude=/dev/* --exclude=/sys/* --exclude=/home/* --exclude=/etc/mtab --exclude=/live --exclude=/run/user/*/gvfs --exclude=/RAM_Session --exclude=/Original_OS --exclude=${DEST} --exclude=*.pyc 2>&1 | tee /tmp/fs_sync
sudo find ${DEST}/var/run ${DEST}/var/crash ${DEST}/var/mail ${DEST}/var/spool ${DEST}/var/lock ${DEST}/var/backups ${DEST}/var/tmp -type f -not -name "root" -exec rm {} \; 2>/dev/null
sudo find ${DEST}/var/log -type f -iregex '.*\.[0-9].*' -exec rm -v {} \;
sudo find ${DEST}/var/log -type f -iname '*.gz' -exec rm -v {} \;
sudo find ${DEST}/var/log -type f | while read file; do echo -n '' | sudo tee $file; done
sudo rm -rfv ${DEST}/home/*/.local/share/gvfs-metadata
rm -rf ${DEST}/var/cache/apt/*

