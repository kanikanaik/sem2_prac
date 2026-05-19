ch = input("1.Local  2.PySpark : ")
if ch == "1":
    try:
        words = open("input.txt").read().lower().split()
        [print(word,":",words.count(word)) for word in set(words)]
    except: print("File not found")
else:
    try:
        from pyspark import SparkContext
        sc = SparkContext("local[*]","WordCount")
        rdd = sc.textFile("input.txt")
        word_counts = rdd.flatMap(lambda line: line.split()) \
                         .map(lambda word: (word.lower(), 1)) \
                         .reduceByKey(lambda a, b: a + b) \
                         .collect()
        [print(word,":",count) for word,count in word_counts]
        sc.stop()
    except Exception as e: print(e)

# def local_wc():
#     try:
#         text = open("input.txt").read().lower().split()
#         print("\nLocal Result:")
#         for w in set(text):
#             print(w, ":", text.count(w))
#     except:
#         print("input.txt not found!")


# def spark_wc():
#     try:
#         from pyspark import SparkContext
#         sc = SparkContext("local[*]", "WC")

#         r = (sc.textFile("input.txt")
#              .flatMap(lambda x: x.split())
#              .map(lambda x: (x.lower(), 1))
#              .reduceByKey(lambda a, b: a + b)
#              .collect())

#         print("\nPySpark Result:")
#         for w, c in r:
#             print(w, ":", c)

#         sc.stop()

#     except Exception as e:
#         print("PySpark Error:", e)


# ch = input("1.Local  2.PySpark : ")
# local_wc() if ch == "1" else spark_wc()