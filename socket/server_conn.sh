#!/bin/bash
source config.sh
echo "python server_connection.py $SERVER_IP_FIRST $SERVER_IP_END $SERVER_IP_PREFIX $SERVER_PORT"
python server_connection.py $SERVER_IP_FIRST $SERVER_IP_END $SERVER_IP_PREFIX $SERVER_PORT
