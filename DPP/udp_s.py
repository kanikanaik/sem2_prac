import socket

server_socket = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)

host = '127.0.0.1'
port = 5000

server_socket.bind((host,port))
print("UDP Server is ready...")

while True:
    data,addr = server_socket.recvfrom(1024)
    print("Client : ",data.decode())
    
    response = input("Server : ")
    server_socket.sendto(response.encode(),addr)
    
server_socket.close()