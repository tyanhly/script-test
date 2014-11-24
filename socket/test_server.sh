#!/bin/bash
source config.sh
ulimit -n $ULIMIT
python server_connection.py $PUB_IP $SERVER_PORT
