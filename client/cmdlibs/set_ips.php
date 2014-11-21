<?php

$params = $_SERVER['argv'];
//var_dump($params);die;
if(count($params) < 2){
  echo "\nTry again\n";
  echo "set_ips.php <mid_start> <mid_end>\n"; 
  
  die;
}
$configs = parse_ini_file(__DIR__ . '/../../config.sh');

if(!file_exists($configs['CLIENT_KISS_IP_FILE'] || !file_exists($configs['CLIENT_KISS_IP_FILE'])){ 
    $cmd = __DIR__ . '/../../startup/network.php';
    `$cmd`
}
$ip = file_get_contents($configs['CLIENT_KISS_IP_FILE']);
$if = file_get_contents($configs['CLIENT_KISS_IF_FILE']);
$arrIp = explode(".", trim($ip));
$start = intval($params[1]);
$end = intval($params[2]);

for($j=0;$i = $start, $i <= $end; $i++;$j++){
 	$arrIp[2] = $i;
	$newIp = implode(".", $arrIp);
	$cmd ="ifconfig $if:$j $newIp";
	echo $cmd . "\n";
	`$cmd`;
}
echo "DONE";
