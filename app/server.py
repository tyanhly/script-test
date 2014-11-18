# Echo server program
import socket

HOST = ''                 # Symbolic name meaning all available interfaces
PORT = 40001              # Arbitrary non-privileged port
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((HOST, PORT))
s.listen(10)
print 'socket listen complete';


while 1:
    conn, addr = s.accept()
    print 'Connected by', addr
    data = conn.recv(1024)
    if not data: break
    conn.sendall("server response")
conn.close()
