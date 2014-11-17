<?php
$port = "22";
$subnet = "192.168.30.0/24";

$result = `nmap -n -p $port $subnet | grep "Nmap scan report"`;

$records = explode("\n", $result);
foreach($records as $record){
   echo $record . "\n";
}
