# Lamport's Mutual Exclusion Algorithm (Simulation)

import heapq

class Process:
    def __init__(self, pid):
        self.pid = pid
        self.clock = 0
        self.queue = []

    def request_cs(self):
        self.clock += 1
        timestamp = self.clock
        heapq.heappush(self.queue, (timestamp, self.pid))
        print(f"Process {self.pid} requests CS at time {timestamp}")
        return (timestamp, self.pid)

    def receive_request(self, request):
        heapq.heappush(self.queue, request)
        self.clock = max(self.clock, request[0]) + 1

    def release_cs(self):
        heapq.heappop(self.queue)
        print(f"Process {self.pid} releases CS")

    def can_enter_cs(self):
        return self.queue[0][1] == self.pid



# Create processes
p1 = Process(1)
p2 = Process(2)
p3 = Process(3)

# Simulate requests
req1 = p1.request_cs()
p2.receive_request(req1)
p3.receive_request(req1)

req2 = p2.request_cs()
p1.receive_request(req2)
p3.receive_request(req2)

# Check who enters CS
if p1.can_enter_cs():
    print("Process 1 enters Critical Section")
    p1.release_cs()

if p2.can_enter_cs():
    print("Process 2 enters Critical Section")
    p2.release_cs()


