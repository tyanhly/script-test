#!/usr/bin/php
<?php

require "_function.php";
$params = $_SERVER['argv'];
//var_dump($params);die;
if(count($params) < 2){
  printHeader("Sorry, don't have this function"); 
  printHelp();
  die;
}

$function = $params[1];
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
  case "runCommand": 
    if(count($params) < 3){
       echo "Sorry, don't have command\n"; die;
    }
    runCommandAllIps($params[2]);
    break;
  case "help": 
    printHelp();
    break;
  default :
    printHeader("Sorry, don't have this function"); 
    printHelp();
    break;
}
