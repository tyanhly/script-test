#!/usr/bin/php
<?php

$devices = explode(" ",trim(`ls /sys/class/net`));

foreach($devices as $k => $v) {
   $v = explode(":", $v)[0];
   $devices[$k] = $v;
}



function check() {
 return  `(ping -c 1 8.8.8.8 > /dev/null 2> /dev/null  && echo 1 ) || echo 0`;
}



foreach($devices as $k => $v) {
  echo "$k $v \n";
  if(check() == "1") {
    break;
  }
  `dhclient -r $v` ;
  `dhclient -1 $v` ;
}




