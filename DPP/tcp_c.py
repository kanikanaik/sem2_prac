import socket

client_socket = socket.socket(socket.AF_INET,socket.SOCK_STREAM)

host = '127.0.0.1'
port = 5000

client_socket.connect((host,port))
print("Connected to TCP SERVER")

while True:
    msg = input("Client : ")
    client_socket.send(msg.encode())
    
    response = client_socket.recv(1024).decode()
    print("Server : ",response)
    
client_socket.close()
