from __future__ import print_function
from gevent.server import StreamServer

def echo(socket, address):
    print(address);
    m = socket.recv(1024);
    print (m)
    socket.sendall(m);
    socket.close();

if __name__ == '__main__':
    server = StreamServer(('0.0.0.0', 7000), echo)
    print('Starting echo server on port 7000')
    server.serve_forever()
