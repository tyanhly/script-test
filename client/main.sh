#!/bin/bash

_SEQUENCE="MD5"
. `dirname $0`/simple_curses.sh


repeat() {
    if [[ $2 -eq 0 ]]; then
      return;
    fi;
    v=`printf "%0.s$1" $(seq 0 $2)`
    echo -en "$v"
}


function bar {
    fill=`bc <<< "scale=2; $1/$2*$3"`
    fill=${fill%.*}
    blank=$(($3-$fill))

    echo -en "["
    repeat "|" $fill
    repeat "." $blank
    echo -en "]"
}

function getCpuPercent {
	cpuPercent=`top -bn1 | grep "Cpu(s)" |            sed "s/.*, *\([0-9.]*\)%* id.*/\1/" |            awk '{print 100 - $1}'`
	echo $cpuPercent
}

function getRamUsage {
	used=`free -m | grep Mem | awk '{print $3}'`
	echo $used
}


function getRamTotal {
	total=`free -m | grep Mem | awk '{print $2}'`
	echo $total
}

main (){
    window "CPU" "red"
    WITHOUTPADDING=$(($LASTCOLS - 7))

    CPU_USAGE=`getCpuPercent`
    
    append  $(bar $CPU_USAGE 100 $WITHOUTPADDING)

    endwin 
    # dmesg | echo "`source ./cpu.sh`" > /tmp/cpu.dmesg
    # while read line; do
    #     append_tabbed "$line" 1 "~"
    # done < /tmp/cpu.dmesg
    # rm -f /tmp/cpu.dmesg
    # endwin 

    window "RAM" "red"

    RAM_USAGE=`getRamUsage`
    RAM_TOTAL=`getRamTotal`

    append  $(bar $RAM_USAGE $RAM_TOTAL $WITHOUTPADDING)

    endwin 
    
    # dmesg | echo "`source ./ram.sh`" > /tmp/ram.dmesg
    # while read line; do
    #     append_tabbed "$line" 1 "~"
    # done < /tmp/ram.dmesg
    # rm -f /tmp/ram.dmesg
    # endwin 

    window "CONNECTIONS" "green"
    dmesg | echo "`source ./connections.sh`" > /tmp/connections.dmesg
    while read line; do
        append_tabbed "$line" 1 "~"
    done < /tmp/connections.dmesg
    rm -f /tmp/connections.dmesg
    endwin 


    window "COMMAND CENTER" "green"
    append "COMMAND INPUT" "blue"
	addsep
    dmesg | echo "`source ./command_center_input.sh`" > /tmp/command_center_input.dmesg
    while read line; do
        append_tabbed "$line" 1 "~"
    done < /tmp/command_center_input.dmesg
    rm -f /tmp/command_center_input.dmesg
 	addsep
	append "COMMAND OUTPUT"	
	addsep

	SEQUENCE="`md5sum ./command.sh`"
	SEQUENCE=${SEQUENCE% *}

	if [ $_SEQUENCE != $SEQUENCE ]
	then
	    _SEQUENCE=$SEQUENCE

		echo $SEQUENCE >> ./tmp.tmp
	    source command_center.sh > command_center_output.txt
	fi
	dmesg | tail command_center_output.txt -n 20 > /tmp/command_center_output.dmesg
    while read line; do
        append_tabbed "$line" 1 "~"
    done < /tmp/command_center_output.dmesg
    rm -f /tmp/command_center_output.dmesg
    endwin 

}
#main
main_loop 1
