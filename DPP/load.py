import random

tasks = [random.randint(1,10) for _ in range(10)]
print(f"Tasks : {tasks}")
nodes = [0,0,0]

for i,t in enumerate(tasks):
    nodes[i % len(nodes)] += t
    
print(f"Static Load Balancing {nodes}")

nodes = [0,0,0]

for t in tasks:
   nodes[nodes.index(min(nodes))] += t
   
print(f"Dynamic Load balancing {nodes}")
