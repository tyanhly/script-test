#!/bin/bash

if [ ! -f /tmp/kiss_startup_check ]; then
dir=$(dirname $0)
echo $dir
source $dir/scan-net.sh
$dir/network.php

git config --global user.name "tyanhly"
git config --global user.email tyanhly@yahoo.com
git config --global push.default simple
touch /tmp/kiss_startup_check

fi
