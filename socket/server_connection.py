import gevent
import sys
from time import time
from gevent import socket
from gevent import sleep
from gevent import Greenlet


##################################################
print "===============SERVER CONNECTION====================="
##################################################

server_port = 8000
connection_amount = 0
p_time = time()
connection_amount_pool = []
rate = []

##################################################
if len(sys.argv) < 4:
  print "params: <server_ip_first> <server_ip_end> <server_ip_prefix> [server_port]"
  sys.exit()

ip_first = int(sys.argv[1])
ip_end = int(sys.argv[2])
ip_prefix = sys.argv[3]

if len(sys.argv) > 4:
  server_port = int(sys.argv[4])

##################################################

def echo(sock, address):
    global connection_amount
    global p_time
    global rate
    connection_amount+=1
    t = time()
    rate.append(t)

    if t - p_time > 1:
      print("connection_amount %s, %s" % (connection_amount, len(rate)))
      p_time = t

    t = t - 1
    while(t > rate[0]):
      rate.pop(0)

    #m = sock.recv(1024);
    #sock.sendall(m);
    connection_amount_pool.append(sock)


def server(ip) :
  sock = socket.socket()
  sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
  print ip + " " + str(server_port)
  sock.bind((ip, server_port))
  sock.listen(65000)
  while(1):
    csock, address = sock.accept()
    Greenlet.spawn(echo, csock, address)
    sleep(0)

servers = []

for offset in range(ip_first, ip_end):
  servers.append(Greenlet.spawn(server, ip_prefix + str(offset)))

gevent.joinall(servers)
