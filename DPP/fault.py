
import random 

last = 0
try:
    f = open("log.txt","r")
    last = int(f.read())
    f.close()
    
except:
    last = 0

print(f"Starting point is : {last}")

try:
    for i in range(last +1,11):
        print("Step",i)
        
        f = open("log.txt","w")
        f.write(str(i))
        f.close()
        
        if random.random() < 0.3:
            raise Exception("Crasheddd")
except:
    print("Failure OCcured, please restart")