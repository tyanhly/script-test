import gevent
import sys
from time import time

from gevent import socket
from gevent import sleep
from gevent import Greenlet



HOST = ""
PORT = 8000
CONNECTION = 0
p_time = time()
connection_pool = []
rate = []

def echo(sock, address):
    global CONNECTION
    global p_time
    global rate
    CONNECTION+=1
    
    t = time()
    rate.append(t)

    if t - p_time > 1:
      print("CONNECTION %s, %s" % (CONNECTION, len(rate)))
      p_time = t

    t = t - 1
    while(t > rate[0]):
      rate.pop(0)

    #m = sock.recv(1024);
    #sock.sendall(m);
    connection_pool.append(sock)


ip_prefix = "192.168.30.%s"
ip_base = 201
ip_max = 40

def server(ip) :
  sock = socket.socket()
  sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

  sock.bind((ip, PORT))
  sock.listen(65000)
  while(1):
    csock, address = sock.accept()
    Greenlet.spawn(echo, csock, address)
    sleep(0)

servers = []

for offset in range(0, ip_max):
  servers.append(Greenlet.spawn(server, ip_prefix % (ip_base+offset)))

gevent.joinall(servers)
