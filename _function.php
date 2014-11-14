<?php
//config

$_port = "22";
$_subnet = "192.168.30.0/24";
$_ips = array();
$_hexIps = array();

function getPort(){
    global $_port;
   return $_port;
}

function getHexPort(){
    return sprintf("00%s", dechex(getPort()));
}

function getSubnet(){
    global $_subnet;
    return $_subnet;
}

function getAllIps(){
    global $_ips;
    if(count($_ips)) return $_ips;
    $port = getPort();
    $subnet = getSubnet();
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

    return $_ips = $ips;
}

function getAllHexIps(){
    global $_hexIps;
    if(count($_hexIps)) return $_hexIps;

    $ips = getAllIps();
    $hexIps = array();
    foreach($ips as $ip){
        $hex = dechex(ip2long($ip));
        $hexIp = substr($hex, 6, 2) 
               . substr($hex, 4, 2) 
               . substr($hex, 2, 2) 
               . substr($hex, 0, 2);
        $hexIps[$ip] = strtoupper($hexIp);
    }
    return $_hexIps = $hexIps;
}

function getIpConnections(){
    $ips = getAllHexIps();
    $port = getHexPort();
    $ipConnections = array();
    foreach($ips as $ip => $hip){
        $count = `cat /proc/net/tcp | grep "$hip:$port" | wc -l`;
        $ipConnections["$ip - $hip"] = trim($count);
    }
    return $ipConnections;
}

function countConnections(){
    $port = getHexPort();
    $cmd = 'cat /proc/net/tcp | grep ".*:.*:.*:'.$port.'" | wc -l';
    echo "\n$cmd\n";
    $count = `$cmd`;
    return trim($count);
}









function printNumberOfConnections(){
    $count = countConnections();
    echo "\nNumber of TCP connections: " . $count;
    echo "\nDone\n";
}
function printAllIps(){
    $ips = getAllIps();
    echo "\nList Ips: \n";
    $result = implode("\n",$ips);
    echo $result;
    echo "\nDone\n";
}

function printAllHexIps(){
    $ips = getAllHexIps();
    echo "\nList HexIps: \n";
    $result = implode("\n",$ips);
    echo $result;
    echo "\nDone\n";
}

function printIpConnections(){
    $ips = getIpConnections();
    echo "\nIp Connections: \n";
    foreach ($ips as $ip => $count){
        echo "$ip: $count connections\n";
    }
    echo "\nDone\n";
}


