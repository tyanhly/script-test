#!/bin/bash


#echo "
##############################
# CONFIGURATION
##############################"
######dhcp
PRI_INTERFACE="prieth0"
PRI_SUBNET="10.0.0.0"
PRI_NETMASK="255.255.0.0"
PRI_RANGE="10.0.0.2 10.0.0.254" 
PRI_BROADCAST="10.0.255.255"
PRI_IP="10.0.0.1"
PRI_IP_PREFIX="10.0."
PRI_IP_SUBFIX="1"
PRE_IP_MID_FIRST=201
PRI_IP_MID_END=240
######nfs
PRI_NFS_BITMASK="16"
PRI_NFS_OS_FILE="filesystem.squashfs"

PUB_INTERFACE="eth0"
PUB_NETMASK="255.255.0.0"
PUB_GATEWAY="192.168.30.1"
PUB_SUBNET="192.168.30.0"
PUB_IP="192.168.30.156"

APT_PROXY_IP="192.168.120.253"

#########################
# CLIENT SETUP
###################3
SEARCH_PORT=22
SEARCH_SUBNET="10.0.0.0/24"
CLIENT_MOUNT_DIR="/mnt/sshfs/"
CLIENT_SCRIPT_DIR="/mnt/"

CLIENT_IP_PREFIX="10.0."
CLIENT_IP_SUBFIX="1"
CLIENT_IP_MID_FIRST=1
CLIENT_IP_MID_END=40

CLIENT_NETWORK_SETUP_FILE="client_network.sh"


#echo "
##############################
# FOR SOCKET APP, PHP TOOL
##############################"
CLIENT_AMOUNT=5
CLIENT_IP_FIRST=201
CLIENT_IP_END=250
CLIENT_IP_PREFIX="10.0."

#SOCKET && PHP TOOL
SERVER_PORT=5555
CONNECTION_MAX=1000
ULIMIT=100000

SERVER_SUBNET="192.168.30.0/24"
IS_CACHE=0
IS_DEBUG=0
MINUTES_EXPIRE_CACHE=5
TMP_DIRECTORY="/tmp/kiss"
IPS_CACHE_FILE_PREFIX="/cache_ips_"
LAST_CONNECTIONS_FILE="/connections_last.db"
