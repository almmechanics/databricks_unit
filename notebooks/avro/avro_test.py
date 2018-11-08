"""Avro import test"""
#pylint: disable=E0602

# Creates a DataFrame from a specified directory
DF = spark.read.format("com.databricks.spark.avro").load("dbfs:/avro/episodes.avro")

#  Saves the subset of the Avro records read in
SUBSET = DF.where("doctor > 5")
SUBSET.write.format("com.databricks.spark.avro").save("dbfs:/avro/avro.output.results")
