import gevent;
from gevent import socket
from gevent import sleep
from gevent import Greenlet

target_address = ("192.168.30.22", 7000)
connection = 1000;

def handle():
  sock = socket.socket()
  sock.connect(target_address)
  sleep(1)
  sock.send("hello");
  print sock.recv(1024);
  global connection;
  connection += 1

def server():
  global connection;
  while(1):
    while(connection > 0):
      connection -= 1
      Greenlet.spawn(handle)
    sleep(1)


g = Greenlet.spawn(server);
g.join()
