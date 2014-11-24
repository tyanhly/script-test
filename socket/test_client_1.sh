#!/bin/bash
source config.sh
python client_connection.py "192.168.\$loop.13" $CLIENT_IP_MID_FIRST $CLIENT_IP_MID_END $PUB_IP $SERVER_PORT 1
