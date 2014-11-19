import gevent
from time import time
import sys

from gevent import socket
from gevent import sleep
from gevent import Greenlet

PORT = 8000
IPADDRESS = "192.168.30.13"
target_address = (IPADDRESS, PORT)
connections = {}
max_connection = 10000000
cur_connection = 0
connection_pool = []
ip_pool = []


ip_first = int(sys.argv[1])
ip_end = int(sys.argv[2])
pre_ip = sys.argv[3]

for ip in range(ip_first, ip_end):
  cur_connection += 1
  ip_pool.append(pre_ip + str(ip))

def handle(ip):
  global connection_pool 
  sock = socket.socket()

  #Bind ip port
  sock.bind((ip, 0))
  #connect server
  #print ip
  sock.connect(target_address)
  global ip_pool
  #send data
  ip_pool.append(ip)
  #sock.send("hello");
  #receive data
  #sock.recv(1024);

  connection_pool.append(sock)

def server():
  global connections;
  global max_connection;
  global cur_connection;
  global ip_pool;
  p_time = time()
  while(cur_connection <  max_connection):
    while(len(ip_pool)):
      cur_connection += 1
      ip = ip_pool.pop()
      Greenlet.spawn(handle, ip)
    sleep(0)
    if time() - p_time > 1:
      print cur_connection;
      p_time = time()
      
  sleep(10000)

g = Greenlet.spawn(server);
g.join()
