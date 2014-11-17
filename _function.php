<?php
//config

$_port = "22";
$_subnet = "10.0.0.0/24";
$_ips = array();
$_hexIps = array();
$_user = 'root';

function getUser(){
    global $_user;
    return $_user;
}

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
        $arrLine1 = explode("map scan report for ", $hr);
        if(count($arrLine1)>1){
            $arrLine0 = explode("\n", $arrLine1[1]);
            if(count($arrLine1)>1){
                $ips[] = $arrLine0[0];
            }
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
        $hexIp = strrev($hex);
#        $hexIp = substr($hex, 6, 2) 
#              . substr($hex, 4, 2) 
#               . substr($hex, 2, 2) 
#               . substr($hex, 0, 2);
        $hexIps[$ip] = strtoupper($hexIp);
    }
    return $_hexIps = $hexIps;
}

function getIpConnections(){
    $ips = getAllHexIps();
    $port = getHexPort();
    $ipConnections = array();
    foreach($ips as $ip => $hip){
        $count = `cat /proc/net/tcp | grep ".*:.*:$port" | grep "$hip" | wc -l`;
        $ipConnections["$ip - $hip"] = trim($count);
    }
    return $ipConnections;
}

function countRemConnections(){
    $port = getHexPort();
    $cmd = 'cat /proc/net/tcp | grep ".*:.*:.*:'.$port.'" | wc -l';
    printInfo("$cmd"); 
    $count = `$cmd`;
    return trim($count);
}

function countLocalConnections(){
    $port = getHexPort();
    $cmd = 'cat /proc/net/tcp | grep ".*:.*:'.$port.'" | wc -l';
    printInfo("$cmd"); 
    $count = `$cmd`;
    return trim($count);
}








function printNumberOfConnections(){
    $lCount = countLocalConnections();
    $rCount = countRemConnections();
    printHeader("TCP connections");
    printInfo("Number of Local TCP connections: " . $lCount);
    printInfo("Number of Rem TCP connections: " . $rCount);
    printInfo("Done\n");
}
function printAllIps(){
    $ips = getAllIps();
    printHeader("List Ips");
    $result = implode("\n",$ips);
    echo $result;
    printInfo("Done\n");
}

function printAllHexIps(){
    $ips = getAllHexIps();
    printHeader("List HexIps");
    $result = implode("\n",$ips);
    echo $result;
    printInfo("Done\n");
}

function printIpConnections(){
    $ips = getIpConnections();
    echo "\nIp Connections: \n";
    foreach ($ips as $ip => $count){
        printInfo("$ip: $count connections");
    }
    printInfo("Done\n");
}

function runRemoteCommand($ip, $command){
    $user = getUser();
    $cmd = "ssh $user@$ip '$command'";
    printHeader("$ip");
    printInfo("Run command: $cmd\n");
    echo `$cmd`;
    printInfo("Machine $ip run command:'$command' is done\n"); 
}

function runCommandAllIps($command){
     $ips = getAllIps();
#    $ips = array('localhost');
    foreach($ips as $ip){    
        runRemoteCommand($ip, $command );
    }

}

function printInfo($msg){
    echo "\nINFO: " . $msg;
}


function printHeader($header){
    $header = strtoupper($header);
    echo "\n*********** $header ***********\n";
}

function printMsg($msg){
    echo "\n$msg";
}

function printHelp(){
    printMsg("ips | hexIps | conn | countConn | runCommand '<linuxCommand>' | help\n");   
}
