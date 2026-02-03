from pyspark.sql import SparkSession
from pyspark.sql.functions import count

spark = SparkSession.builder \
    .appName("Log Analysis") \
    .getOrCreate()

logs_df = spark.read.json("datasets/app_logs.json")

error_count_df = logs_df \
    .filter(logs_df.level == "ERROR") \
    .groupBy("date") \
    .agg(count("*").alias("error_count"))

error_count_df.show()

spark.stop()
