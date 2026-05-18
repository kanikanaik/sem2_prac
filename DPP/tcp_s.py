import socket

server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

host = '127.0.0.1'
port = 5000

server_socket.bind((host,port))
server_socket.listen(5)

print("TCP Server is waiting for connection ")

conn,addr = server_socket.accept()
print("Connected to : ",addr)

while True:
    data = conn.recv(1024).decode()
    if not data:
        break
    
    print("Client : ",data)
    response = input("Server : ")
    conn.send(response.encode())
    

conn.close()
server_socket.close()