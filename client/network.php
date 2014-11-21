#!/usr/bin/php
<?php
function getInterfaceAndIpClient(){
    $ifconfig = `ifconfig -a`;
    $interfaces = explode("\n\n",$ifconfig);

    #print_r($interfaces);die;
    foreach($interfaces as $i){
       if($last = strpos($i, "Bcast:192.168.30.255")){
            $first = strpos($i, "inet addr:") + strlen("inet addr:");
            $ip = trim(substr($i, $first, $last-$first));
            $arr = array($i,$ip);
            return $arr;
       }
    }
}

$result = getInterfaceAndIpClient();
file_put_content("/tmp/kissip",$result[1])
file_put_content("/tmp/kissinterface",$result[0])