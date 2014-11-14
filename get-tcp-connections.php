#!/usr/bin/php
<?php
//config
$port = "0016";

//variable
$ips = array();

$getConnsCommand = `cat /proc/net/tcp | grep ".*:.*:.*:$port"`;

$hostRecords = explode("\n", trim($getConnsCommand));
#print_r($hostRecords);die;
foreach($hostRecords as $hr){
    $arrFields = explode(" ", $hr);

    $arrField = explode(":", $arrFields[2]);
    $ips[] = hexdec(substr($arrField[0],6,2)) . "."
           . hexdec(substr($arrField[0],4,2)) . "."
           . hexdec(substr($arrField[0],2,2)) . "."
           . hexdec(substr($arrField[0],0,2)) ;
}

print_r($ips);
