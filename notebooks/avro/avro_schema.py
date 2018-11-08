"""Avro schema read"""

READER = avro.datafile.DataFileReader(open('dbfs:/avro/episodes.avro',"rb"),avro.io.DatumReader())
SCHEMA = READER.meta
print(SCHEMA) 