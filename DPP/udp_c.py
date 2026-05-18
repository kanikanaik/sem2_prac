import socket

client_socket = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)

host = '127.0.0.1'
port = 5000

while True:
    msg = input("Client : ")
    client_socket.sendto(msg.encode(), (host,port))
    data,addr = client_socket.recvfrom(1024)
    print("Server : ",data.decode())