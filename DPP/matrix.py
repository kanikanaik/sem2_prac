import multiprocessing,time

SIZE = 3

A = [[i + j for j in range(SIZE)] for i in range(SIZE)]
B = [[i * j for j in range(SIZE)] for i in range(SIZE)]

def multiply(i):
    return [
        sum(A[i][k] * B[k][j] for k in range(SIZE)) for j in range(SIZE)
    ]
    
    #  return [
    #     sum(A[i][k] * B[k][j] for k in range(SIZE))
    #     for j in range(SIZE)
    # ]


if __name__ == "__main__":
    
    print("Matrix A")
    for row in A:
        print(row)
    
    print("Matrix B")
    for row in B:
        print(row)
    
    t1 = time.time()
    seq = [multiply(i) for i in range(SIZE)]
    
    print("Sequential Run : ", time.time() - t1)
    
    
    t2 = time.time()
    with multiprocessing.Pool() as p:
        result = p.map(multiply,range(SIZE))
        
    print("Result Matrix")
    for row in result:
        print(row)
    print("Sequential Run : ", time.time() - t1)
    
        
        