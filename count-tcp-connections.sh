HEXPORT="0016"
echo "Number of TCP connections: "
cat /proc/net/tcp | grep ".*:.*:.*:$HEXPORT" | wc -l
