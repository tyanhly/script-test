import gevent
import sys

from time import time
from gevent import socket
from gevent import sleep
from gevent import Greenlet
##################################################
print "===============CLIENT CONNECTION====================="
##################################################

max_connection = 10000000
cur_connection = 0
pre_connection = 0
connection_pool = []
client_ip_pool = []
server_ip_pool = []

##################################################
if len(sys.argv) < 8:
  print "params: <client_ip_first> <client_ip_end> <client_ip_prefix> <server_ip_first> <server_ip_end> <server_ip_prefix> <server_port> [max_connection]"
  sys.exit()

ip_first = int(sys.argv[1])
ip_end = int(sys.argv[2])
ip_prefix = sys.argv[3]

server_ip_first = int(sys.argv[4])
server_ip_end = int(sys.argv[5])
server_ip_prefix = sys.argv[6]
server_port = sys.argv[7]

if len(sys.argv) > 8:
  max_connection = int(sys.argv[8])


for ip in range(ip_first, ip_end):
  client_ip_pool.append(ip_prefix + str(ip))

for ip in range(server_ip_first, server_ip_end):
  server_ip_pool.append(server_ip_prefix + str(ip))

##################################################


def handle(ip_client, ip_server):
  global server_port
  global connection_pool 
  global client_ip_pool

  sock = socket.socket()
  sock.bind((ip_client, 0))
  sock.connect((ip_server, server_port))

  client_ip_pool.append(ip_client)
  connection_pool.append(sock)

def server():
  global max_connection
  global cur_connection
  global pre_connection
  global ip_pool
  p_time = time()
  while(cur_connection <  max_connection):
    while(len(server_ip_pool)):
      ip_server = server_ip_pool.pop()
      while(len(client_ip_pool)):
        cur_connection += 1
        ip_client = client_ip_pool.pop()

        Greenlet.spawn(handle, ip_client, ip_server)
      sleep(0)
      server_ip_pool.append(ip_server)
      if time() - p_time > 1:
        print "%s, %s" % (cur_connection, cur_connection - pre_connection)
        p_time = time()
        pre_connection = cur_connection
      
  sleep(10000)


##################################################


g = Greenlet.spawn(server);
g.join()
