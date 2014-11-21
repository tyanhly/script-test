#!/bin/bash
dir=$(dirname $0)
echo $dir
source $dir/scan-net.sh
$dir/network.php

ulimit -n 10000000
cat kisssysctl.conf > /etc/sysctl.conf
sysctl -p

git config --global user.name "tyanhly"
git config --global user.email tyanhly@yahoo.com
git config --global push.default simple
