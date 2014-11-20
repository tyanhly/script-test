#!/bin/bash 

_SEQUENCE="MD5"
while [ 1 ]; do
clear
source cpu.sh
source ram.sh
source connections.sh
source command_center_input.sh
cat command_center_output.txt

SEQUENCE="`md5sum command.sh`"
SEQUENCE=${SEQUENCE% *}

if [ $_SEQUENCE != $SEQUENCE ]
then
    _SEQUENCE=$SEQUENCE
    source command_center.sh | tail -c 1000 > command_center_output.txt
fi
sleep 1

done
