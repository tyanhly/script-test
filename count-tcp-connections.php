#!/usr/bin/php
<?php
//config
$port = "0016";

//variable
$ips = array();

$getConnsCommand = `cat /proc/net/tcp | grep ".*:.*:.*: $port" | wc -l`;

echo "\nNumber of TCP connections:" . $getConnsCommand . "\n";
