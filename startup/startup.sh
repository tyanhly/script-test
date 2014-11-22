#!/bin/bash

if [ ! -f /tmp/kiss_startup_check ]; then
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
  touch /tmp/kiss_startup_check
  $dir/../client/run/loop.sh > /dev/null 2> /dev/null &
  clear
fi
