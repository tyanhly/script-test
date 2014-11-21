#!/bin/bash 
_SEQUENCE="hello"
while [ 1 ]; do

SEQUENCE=$(wget http://localhost/abc.html -q -O -)

if [ "$_SEQUENCE" != "$SEQUENCE" ]
then
_SEQUENCE=$SEQUENCE
echo "$SEQUENCE" > /tmp/kiss_client_command.sh
echo "`source /tmp/kiss_client_command.sh`" > /tmp/kiss_client_command.output
fi
sleep 1

done
