#!/usr/bin/php
<?php
$params = $_SERVER['argv'];

if(count($params) < 1){
   echo "Sorry, don't have this function"; die;
}

$function = $params[1];
require "_function.php";
switch($function){
  case "ips": 
    printAllIps();
    break;
  case "hexIps": 
    printAllHexIps();
    break;
  case "conn": 
    printIpConnections();
    break;
  case "countConn": 
    printNumberOfConnections();
    break;
  case "help": 
    echo "\nips | hexIps | conn | countConn | help\n";    
    break;
  default :
    echo "Please type help for support";
}
