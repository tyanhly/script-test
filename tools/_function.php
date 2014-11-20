<?php

//config f 
$configs = parse_ini_file("../config.conf");

 
$_port   =$configs["SEARCH_PORT"];
$_subnet =$configs["SEARCH_SUBNET"];

// $_port   = "443";
#$_subnet = "192.168.30.0/24";
 
$_isCache = $configs["IS_CACHE"];
$_isDebug = $configs["IS_DEBUG"];

$_date = date("Ymd-H") . "-" . intval(date("m")/intval($configs['MINUTES_EXPIRE_CACHE']));
$_ipsCacheFile = $configs['TMP_DIRECTORY'] . $configs["IPS_CACHE_FILE_PREFIX"] . $_date . ".txt" ;
$_connectionsFile = $configs['TMP_DIRECTORY'] . $configs['LAST_CONNECTIONS_FILE'];
if(!file_exists($configs['TMP_DIRECTORY'])){
    mkdir($configs['TMP_DIRECTORY'] , 0777, true);
}

$_ips = array();
$_hexIps = array();
$_user = 'root';

function getUser(){
    printInfo("Func: " . __METHOD__);
    global $_user;
    return $_user;
}

function getPort(){
    printInfo("Func: " . __METHOD__);
    global $_port;
    return $_port;
}

function getHexPort(){
    printInfo("Func: " . __METHOD__);
    return sprintf("00%s", dechex(getPort()));
}

function getSubnet(){
    printInfo("Func: " . __METHOD__);
    global $_subnet;
    return $_subnet;
}

function getAllIps(){
    printInfo("Func: " . __METHOD__);
    global $_ips, $_isCache, $_ipsCacheFile;
    if(count($_ips)) return $_ips;

    if ($_isCache && file_exists($_ipsCacheFile)) {
        $_ips = unserialize(file_get_contents($_ipsCacheFile));
        return $_ips;
    } 

    $port = getPort();
    $subnet = getSubnet();
    $ips = array();
    $cmd = "nmap --open -n -p $port $subnet";
    $getIpsCommand = `$cmd`;

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
    cache($_ipsCacheFile, serialize($ips));
    return $_ips = $ips;
}

function cache($file, $content){
    printInfo("Func: " . __METHOD__);
    global $_isCache;
    !$_isCache or file_put_contents($file, $content);
}


function save($file, $content){

    printInfo("Func: " . __METHOD__);
    file_put_contents($file, $content);
}

function getAllHexIps(){
    printInfo("Func: " . __METHOD__);
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
    global $_connectionsFile;
    printInfo("Func: " . __METHOD__);
    $ips = getAllHexIps();
    $port = getHexPort();
    $ipConnections = array();
    $lastIpConnections = array();
    $isFirstTime = file_exists($_connectionsFile);
    if($isFirstTime){
        $lastIpConnections = unserialize(file_get_contents($_connectionsFile));
    }
    foreach($ips as $ip => $hip){
        $count = `cat /proc/net/tcp | grep ".*:.*:$port" | grep "$hip" -c`;
        $count = intval($count);
        $rate = 0;
        $max = 0;
        if(!$isFirstTime){
            if(isset($lastIpConnections['$ip - $hip'])){
                $record = $lastIpConnections['$ip - $hip'];
                $max = $count - $record['count'];
                $rate = ($max)/(time() - filemtime($_connectionsFile));
                $max = ($max > $record['max'])?$max:$record['max'];
            }   
        }
        $ipConnections["$ip - $hip"] = array("count" => $count, "rate" => $rate, "max" => $max);
    }
    save($_connectionsFile, serialize($ipConnections));
    return $ipConnections;
}

function countRemConnections(){
    printInfo("Func: " . __METHOD__);
    $port = getHexPort();
    $cmd = 'cat /proc/net/tcp | grep ".*:.*:.*:'.$port.'" | wc -l';
    printInfo("$cmd"); 
    $count = `$cmd`;
    return trim($count);
}

function countLocalConnections(){
    printInfo("Func: " . __METHOD__);
    $port = getHexPort();
    $cmd = 'cat /proc/net/tcp | grep ".*:.*:'.$port.'" | wc -l';
    printInfo("$cmd"); 
    $count = `$cmd`;
    return trim($count);
}








function printNumberOfConnections(){
    printInfo("Func: " . __METHOD__);
    $lCount = countLocalConnections();
    $rCount = countRemConnections();
    printHeader("TCP connections");
    printInfo("Number of Local TCP connections: " . $lCount);
    printInfo("Number of Rem TCP connections: " . $rCount);
    printInfo("Done\n");
}
function printAllIps(){
    printInfo("Func: " . __METHOD__);
    $ips = getAllIps();
    printHeader("List Ips");
    $result = implode("\n",$ips);
    echo $result;
    printInfo("Done\n");
}

function printAllHexIps(){
    printInfo("Func: " . __METHOD__);
    $ips = getAllHexIps();
    printHeader("List HexIps");
    $result = implode("\n",$ips);
    echo $result;
    printInfo("Done\n");
}

function createMountPoints(){
    $ips = getAllIps();
    global $_user;
    foreach($ips as $ip){
        $dir = "/mnt/$ip";
        `mkdir $dir -p`;
        `umount $dir`;
        `sshfs $_user@$ip:/ $dir`;
    }
}


function copyScriptToClients(){
    $ips = getAllIps();
    foreach($ips as $ip){
        $dir = "/mnt/$ip";
        if(file_exists($dir)){
            `cp -r ../client $dir`
        }
    }
}

function printIpConnections(){
    printInfo("Func: " . __METHOD__);
    $ips = getIpConnections();
    echo "\nIp Connections: \n";
    foreach ($ips as $ip => $record){
        $count = $record['count'];
        $rate = $record['rate'];
        $max = $record['max'];
        printInfo("$ip >> count:$count, rate: $rate, max: $max");
    }
    printInfo("Done\n");
}

function runRemoteCommand($ip, $command){
    printInfo("Func: " . __METHOD__);
    $user = getUser();
    $cmd = "ssh $user@$ip '$command'";
    printHeader("$ip");
    printInfo("Run command: $cmd\n");
    echo `$cmd`;
    printInfo("Machine $ip run command:'$command' is done\n"); 
}

function runCommandAllIps($command){
    printInfo("Func: " . __METHOD__);
     $ips = getAllIps();
#    $ips = array('localhost');
    foreach($ips as $ip){    
        runRemoteCommand($ip, $command );
    }

}

function printInfo($msg){
    global $_isDebug;
    if($_isDebug){
        $date = date("Ymd-H:m:s");
        echo "\n$date: INFO: " . $msg;
    }else{
        echo "\n$msg";
    }
}


function printHeader($header){
    $header = strtoupper($header);
    echo "\n*******************************\n";
    echo "\n        $header \n";
    echo "\n*******************************\n";
}

function printMsg($msg){
    echo "\n$msg";
}

function printHelp(){
    printMsg("ips | hexIps | conn | countConn | runCommand '<linuxCommand>' | help\n");   
}
