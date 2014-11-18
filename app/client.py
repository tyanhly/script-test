# Echo client program
import socket
import sys
import time

HOST = '192.168.30.226'    # The remote host
PORT = 40001              # The same port as used by the server


ip = sys.argv[1]
port = int(sys.argv[2])

print "binding to ", ip, port

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# s.bind((ip, port))
s.connect((HOST, PORT))
s.sendall('Hello, world')

i = 0
while 1:
    data = s.recv(1024)
    i = i+1
    print i, ' Received', repr(data)
        
