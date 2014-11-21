#!/usr/bin/php
<?php
$configs = parse_ini_file(__DIR__ . '/../config.sh');
#var_dump($configs);die;
function getInterfaceAndIpClient(){
    global $configs;
    $ifconfig = `ifconfig -a`;
    $interfaces = explode("\n\n",$ifconfig);

    #print_r($interfaces);die;
    foreach($interfaces as $i){
       if($last = strpos($i, "Bcast:{$configs['PUB_BROADCAST']}")){
            $ifname = explode(" ",$i);
            $ifname = trim($ifname[0]);
            $first = strpos($i, "inet addr:") + strlen("inet addr:");            
            
            if($first<0) return array($ifname, $configs['PUB_IP']);

            $ip = trim(substr($i, $first, $last-$first));
            $arr = array($ifname,$ip);
            print_r($arr);die;
            return $arr;
       }else if(strpos($i, "HWaddr")){
            $ifname = explode(" ",$i);
            $ifname = trim($ifname[0]);
            return array($ifname, $configs['PUB_IP']);
           
       }
    }
    return null;
}

$result = getInterfaceAndIpClient();
#var_dump($result);die;
if($result){
    $cmd = "ifconfig {$result[0]} {$result[1]}";
    echo $cmd . "\n" ;
    `$cmd`;
    $cmd = "route del default";
    echo $cmd . "\n" ;
    `$cmd`;
    $cmd = "ip route add default via {$result[1]}";
    echo $cmd . "\n" ;
    `$cmd`;
    file_put_contents("/tmp/kiss_ip",$result[1]);
    file_put_contents("/tmp/kiss_interface",$result[0]);
}
