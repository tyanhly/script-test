#!/usr/bin/php
<?php
//config
$port = "22";
$subnet = "192.168.30.0/24";

//variable
$ips = array();

$getIpsCommand = `nmap --open -n -p $port $subnet`;

$hostRecords = explode("\n\n", $getIpsCommand);

foreach($hostRecords as $hr){
    $arrLines = explode("\n", $hr);
    $arrLine0 = explode("Nmap scan report for ", $arrLines[0]);
    if(count($arrLine0)>1){
       $ips[] = $arrLine0[1];
    }
}

print_r($ips);
