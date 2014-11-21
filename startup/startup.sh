#!/bin/bash
dir=$(dirname $SOURCE_BASH[0])

source $dir/scan-net.sh
$dir/network.php

git config --global user.name "tyanhly"
git config --global user.email tyanhly@yahoo.com
git config --global push.default simple
