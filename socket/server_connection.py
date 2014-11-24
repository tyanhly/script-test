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
if len(sys.argv) < 2:
  print "params: <server_server_ip> [server_port]"
  sys.exit()

server_server_ip = sys.argv[1]
server_port = int(sys.argv[2])

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


def server(server_ip, server_port) :
  sock = socket.socket()
  sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
  print server_ip + " " + str(server_port)
  sock.bind((server_ip, server_port))
  sock.listen(65000)
  while(1):
    csock, address = sock.accept()
    Greenlet.spawn(echo, csock, address)
    sleep(0)


g = Greenlet.spawn(server, server_server_ip, server_port)

g.join()
