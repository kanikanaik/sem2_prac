from multiprocessing import Process, Queue

def merge(left, right):
    result = []
    i = j = 0
    while i < len(left) and j < len(right):
        if left[i] < right[j]: result.append(left[i]); i += 1
        else: result.append(right[j]); j += 1
    return result + left[i:] + right[j:]

def merge_sort(arr):
    if len(arr) <= 1: return arr
    mid = len(arr) // 2
    return merge(merge_sort(arr[:mid]), merge_sort(arr[mid:]))

def parallel_sort(arr, q):
    q.put(merge_sort(arr))

if __name__ == "__main__":
    arr = [8, 3, 7, 4, 9, 2, 6, 5]
    mid = len(arr) // 2
    q1, q2 = Queue(), Queue()
    p1 = Process(target=parallel_sort, args=(arr[:mid], q1))
    p2 = Process(target=parallel_sort, args=(arr[mid:], q2))
    p1.start(); p2.start()
    sorted_arr = merge(q1.get(), q2.get())
    p1.join(); p2.join()
    print("Original:", arr)
    print("Sorted:", sorted_arr)
