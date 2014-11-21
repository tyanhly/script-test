#!/usr/bin/php
<?php
$configs = parse_ini_file(__DIR__ . '/../config.sh');
function getInterfaceAndIpClient(){
    $ifconfig = `ifconfig -a`;
    $interfaces = explode("\n\n",$ifconfig);

    #print_r($interfaces);die;
    foreach($interfaces as $i){
       if($last = strpos($i, "Bcast:192.168.30.255")){
            $ifname = explode(" ",$i);
            $ifname = trim($ifname[0]);
            $first = strpos($i, "inet addr:") + strlen("inet addr:");            
            if($first<0) return array($ifname, $configs['IP_PUB']);

            $ip = trim(substr($i, $first, $last-$first));
            $arr = array($ifname,$ip);
#            print_r($arr);die;
            return $arr;
       }
    }
}

$result = getInterfaceAndIpClient();

$cmd = "ifconfig {$result[0]} {$result[1]}";
`$cmd`;
`route del default`;
`ip route add default via $result[1]`;
file_put_contents("/tmp/kissip",$result[1]);
file_put_contents("/tmp/kissinterface",$result[0]);
