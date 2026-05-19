import time 
import random 

class TimeServer:
    def get_time(self):
        return time.time()
    
class Client:
    def __init__(self,clock_offset):
        self.clock_offset = clock_offset
        
    def get_local_time(self):
        return time.time() + self.clock_offset
    
    def sync(self,server):
        t1 = self.get_local_time()
        
        time.sleep(random.uniform(0.1,0.5))
        
        server_time = server.get_time()
        t2 = self.get_local_time()
        
        rtt = t2 - t1
        adjusted_time = server_time + (rtt/2)
        self.clock_offset = adjusted_time - time.time()
        
        print("New Client time is ",self.get_local_time())
        

if __name__ == "__main__":
    server = TimeServer()
    client = Client(clock_offset=-5)
    
    print("Initital time is ",server.get_time())
    print("Client now time ",client.get_local_time())
    client.sync(server)
    
   
   