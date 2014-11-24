import gevent
import sys
import string

from time import time
from gevent import socket
from gevent import sleep
from gevent import Greenlet
##################################################
print "===============CLIENT CONNECTION====================="
##################################################

max_connection = 1
cur_connection = 0
pre_connection = 0
connection_pool = []
client_ip_pool = []
server_ip_pool = []

##################################################
if len(sys.argv) < 5:
  print "params: <client_ip_template> <first> <end> <server_ip> <server_port> [max_connection]"
  sys.exit()

client_ip_template = sys.argv[1]
client_ip_loop_first = int(sys.argv[2])
client_ip_loop_end = int(sys.argv[3])

server_ip = sys.argv[4]
server_port = int(sys.argv[5])

max_connection = (client_ip_loop_end - client_ip_loop_first)*50000
print "MAX AVAILABLE NUBMER OF CONNECTION IS: " + str(max_connection)
if len(sys.argv) > 6:
  max_connection = int(sys.argv[6])

print "Your max connection is: " + str(max_connection)

for ip in range(client_ip_loop_first, client_ip_loop_end):
  ip_address = string.Template(client_ip_template).substitute({'loop':ip})
  #print ip_address
  client_ip_pool.append(ip_address)

##################################################


def handle(client_ip, server_ip, server_port):
  global connection_pool 
  global client_ip_pool
   
  sock = socket.socket()
  
  sock.bind((client_ip, 0))
  sock.connect((str(server_ip), int(server_port)))

  client_ip_pool.append(client_ip)
  connection_pool.append(sock)

def server():
  global max_connection
  global cur_connection
  global pre_connection
  global ip_pool
  global server_ip
  global server_port
  p_time = time()
  while(cur_connection <  max_connection):
    while(len(client_ip_pool) and (cur_connection <  max_connection)):
      cur_connection += 1
      client_ip = client_ip_pool.pop()
      Greenlet.spawn(handle, client_ip, server_ip, server_port)
    sleep(0)
    if time() - p_time > 1:      
      print "%s, %s" % (cur_connection, cur_connection - pre_connection)
      p_time = time()
      pre_connection = cur_connection
      
  sleep(10000)


##################################################


g = Greenlet.spawn(server);
g.join()
