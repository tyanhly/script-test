#!/bin/bash


#echo "
##############################
# CONFIGURATION
##############################"
######dhcp

PUB_NFS_BITMASK="24"
PUB_NFS_OS_FILE="/mnt/live/filesystem.squashfs"

PUB_INTERFACE="p4p1"
PUB_SUBNET="192.168.30.0"
PUB_NETMASK="255.255.255.0"
PUB_RANGE="192.168.30.201 192.168.30.254" 
PUB_BROADCAST="192.168.30.255"
PUB_IP="192.168.30.200"

PUB_IP_PREFIX="192.168.31."
PUB_IP_MID_FIRST=201
PUB_IP_MID_END=240

APT_PROXY_IP="192.168.120.253"

#########################
# CLIENT SETUP
###################3
SEARCH_PORT=22
SEARCH_SUBNET="192.168.30.0/24"
CLIENT_MOUNT_DIR="/mnt/sshfs/"
CLIENT_SCRIPT_DIR="/tmp/"

CLIENT_IP_PREFIX="192.168."
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
CLIENT_IP_PREFIX="192.168."

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
