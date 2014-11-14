#!/usr/bin/python

# pypy 6 faster python
# gevent coroutine

# sftp | rypc
#  

import socket
import time
import sys
import time
import sys

target_address = ("192.168.30.99", 10000)

pool = []
rate = []

ip_start = int(sys.argv[1])
ip_count = 1

for ip in range(ip_start, ip_start + ip_count ):
  ip = "192.168.30." + str(ip)
  for port in range(0, 45000):
    print "binding to",ip,port,len(rate)
    sock = socket.socket()
    sock.bind((ip, 0))
    sock.connect(target_address)
    pool.append(sock)
    t = time.time()
    rate.append(t)
    t = t - 1
    while(t > rate[0]):
      rate.pop(0)
    

try:
  time.sleep(10000)
except:
  for s in pool:
    s.close();
    time.sleep(0.001);

