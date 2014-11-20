#!/bin/bash

. `dirname $0`/simple_curses.sh

main (){
    window "CONNECTION" "red"
    appendTung "`tail ./command_center_output.txt -n 10`" left
    endwin
    window "CONNECTION" "red" 
    appendTung "`tail ./command_center_output.txt -n 10`"
    endwin
    window "CONNECTION" "red"
    appendTung "`tail ./command_center_output.txt -n 10`"
    endwin
}
#main
main_loop 1
