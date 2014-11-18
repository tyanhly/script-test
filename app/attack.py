# Echo client program
import socket
import sys
import time
import os

#os.system("python ./client.py 1")

ip_first = int(sys.argv[1])
ip_end = int(sys.argv[2])

port_first = int(sys.argv[3])
port_end = int(sys.argv[4])

pre_ip = sys.argv[5]
#pre_ip = "192.168.30."

for ip in range(ip_first, ip_end):
    ip = pre_ip + str(ip);
    for port in range (port_first, port_end):
        print "binding to ", ip, port
        os.system("python ./client.py " + str(ip) + " " + str(port) + " & > /dev/null 2> /dev/null")
        
