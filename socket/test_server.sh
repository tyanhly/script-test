#!/bin/bash
source config.sh
ulimit -n $ULIMIT
#echo "python server_connection.py $PUB_IP_MID_FIRST.$PUB_IP_SUBFIX $PUB_IP_MID_END $PUB_IP_PREFIX $PUB_IP_SUBFIX $SERVER_PORT"
echo "python server_connection.py $PUB_IP_MID_FIRST $PUB_IP_MID_END $PUB_IP_PREFIX $PUB_IP_SUBFIX $SERVER_PORT"
python server_connection.py $PUB_IP_MID_FIRST $PUB_IP_MID_END $PUB_IP_PREFIX $PUB_IP_SUBFIX $SERVER_PORT
