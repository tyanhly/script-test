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

msg_amount = 1
cur_msg_amount = 0
pre_msg_amount = 0

process_amount = 0;


##################################################
if len(sys.argv) < 4:
  print "params: <server_ip> <server_port> <msg> [msg_amount]"
  sys.exit()

server_ip = sys.argv[1]
server_port = int(sys.argv[2])
msg = sys.argv[3]

if len(sys.argv) > 4:
  msg_amount = int(sys.argv[4])

print "Your Msg: '" + msg + "', Amount: " + str(msg_amount)

##################################################


def handle(server_ip, server_port, msg):
  global process_amount
  process_amount += 1
  sock = socket.socket()
  print "Start send msg: " + msg + " to " + server_ip + ":" + str(server_port)
  sock.connect((str(server_ip), int(server_port)))
  sock.sendall(msg)
  data = sock.recv(1024)
  if len(data) >0 :
    print str(process_amount) + ' - Received from ' + server_ip + ":" + repr(data)
    sock.close()
    process_amount -=1
  

def server():
  global msg_amount
  global cur_msg_amount
  global pre_msg_amount
  global server_ip
  global server_port
  global msg

  p_time = time()
  while(cur_msg_amount <  msg_amount):
    cur_msg_amount += 1
    Greenlet.spawn(handle, server_ip, server_port, msg)
    sleep(0)
 

##################################################


g = Greenlet.spawn(server);
g.join()
while(process_amount > 0):
  print "Process amount: " + str(process_amount)
  sleep(1)