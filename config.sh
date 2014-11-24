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
PUB_IP="192.168.30.13"

PUB_IP_PREFIX="192.168."
PUB_IP_SUBFIX=".13"
PUB_IP_MID_FIRST=30
PUB_IP_MID_END=31

APT_PROXY_IP="192.168.120.253"

#########################
# CLIENT SETUP
###################3
SEARCH_PORT=22222
SEARCH_SUBNET="192.168.30.0/24"
CLIENT_MOUNT_DIR="/mnt/sshfs/"
CLIENT_SCRIPT_DIR="/tmp/"

CLIENT_IP_MID_FIRST=31
CLIENT_IP_MID_END=70

CLIENT_NETWORK_SETUP_FILE="client_network.sh"

CLIENT_KISS_IP_FILE="/tmp/kiss_ip"
CLIENT_KISS_IF_FILE="/tmp/kiss_if"
CLIENT_KISS_SERVER_IP_FILE="/tmp/kiss_server_ip"

#echo "
##############################
# FOR SOCKET APP, PHP TOOL
##############################"
#SOCKET && PHP TOOL
SERVER_KISS_NAME="ile "/usr/local/lib/python2.7/dist-packages/gevent/socket.py", line 227, in __init__
error: [Errno 24] Too many open files
kiss.server"
SERVER_KISS_COMMAND_FILE="command.html"
SERVER_PORT=5500
SERVER_SUBNET="192.168.30.0/24"
CONNECTION_MAX=1000
ULIMIT=100000

IS_CACHE=0
IS_DEBUG=0
MINUTES_EXPIRE_CACHE=5
TMP_DIRECTORY="/tmp/kiss"
IPS_CACHE_FILE_PREFIX="/kiss_cache_ips_"
LAST_CONNECTIONS_FILE="/kiss_connections_last.db"
