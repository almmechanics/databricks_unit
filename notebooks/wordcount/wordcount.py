"""Wordcount a specified file"""
#pylint: disable=E0602
TEXT_FILE = sc.textFile("dbfs:/wordcount/document.txt")
COUNTS = TEXT_FILE.flatMap(lambda line: line.split(" ")) \
             .map(lambda word: (word, 1)) \
             .reduceByKey(lambda a, b: a + b)
COUNTS.saveAsTextFile("dbfs:/wordcount/document-count.results")
