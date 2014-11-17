sudo find /var/squashfs/var/run /var/squashfs/var/crash /var/squashfs/var/mail /var/squashfs/var/spool /var/squashfs/var/lock /var/squashfs/var/backups /var/squashfs/var/tmp -type f -not -name "root" -exec rm {} \; 2>/dev/null
sudo find /var/squashfs/var/log -type f -iregex '.*\.[0-9].*' -exec rm -v {} \;
sudo find /var/squashfs/var/log -type f -iname '*.gz' -exec rm -v {} \;
sudo find /var/squashfs/var/log -type f | while read file; do echo -n '' | sudo tee $file; done
sudo rm -rfv /var/squashfs/home/*/.local/share/gvfs-metadata
rm -rf /var/squashfs/var/cache/apt/*

