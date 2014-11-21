#!/bin/bash 
dir=$(dirname $0)
echo $dir
source $dir/../../config.sh

_SEQUENCE="hello"
while [ 1 ]; do

SEQUENCE=$(wget http://$SERVER_KISS_NAME/$SERVER_KISS_COMMAND_FILE -q -O -)

if [ "$_SEQUENCE" != "$SEQUENCE" ]
then
_SEQUENCE=$SEQUENCE
echo "$SEQUENCE" > /tmp/kiss_client_command.sh
echo "`source /tmp/kiss_client_command.sh`" > /tmp/kiss_client_command.output
fi
sleep 1

done
