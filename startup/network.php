#!/usr/bin/php
<?php
$configs = parse_ini_file(__DIR__ . '/../config.sh');
var_dump($configs);die;
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
            
            if($first<0) return array($ifname, $configs['PUB_IP'], 'server');

            $ip = trim(substr($i, $first, $last-$first));
            $arr = array($ifname,$ip,'client');
            #print_r($arr);die;
            return $arr;
       }else if(strpos($i, "HWaddr")){
            $ifname = explode(" ",$i);
            $ifname = trim($ifname[0]);
            return array($ifname, $configs['PUB_IP'], 'server');
           
       }
    }
    return null;
}
echo "Begin"
$result = getInterfaceAndIpClient();

var_dump($result);
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
    file_put_contents($configs['CLIENT_KISS_IP_FILE'],$result[1]);
    file_put_contents($configs['CLIENT_KISS_IF_FILE'],$result[0]);
    
    if($result[2]=='client'){
       $subnet = explode(".", $result[1]);
       unset($subnet[3]);
       $subnet = implode(".", $subnet) . ".0/24";
       $cmd=`nmap --open -n -p 2049 $subnet | grep "scan report for"| awk '{print $5}'`;
       if($cmd = trim($cmd)){
           $serIpFile = $configs['CLIENT_KISS_SERVER_IP_FILE'];
           $serName = $configs['SERVER_KISS_NAME'];
           `echo "$cmd >> $serIpFile"`;
           `echo "$cmd $serName" >> /etc/hosts`;
       }
    }
}
