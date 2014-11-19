from __future__ import print_function
from gevent.server import StreamServer

HOST = ""
PORT = 8000
CONNECTION = 0

def echo(socket, address):
    m = socket.recv(1024);
    socket.sendall(m);
    socket.close();
    global CONNECTION
    CONNECTION+=1
    print("CONNECTION %s" % CONNECTION)

if __name__ == '__main__':
    server = StreamServer((HOST, PORT), echo)
    print('Starting echo server on port 7000')
    server.serve_forever()
