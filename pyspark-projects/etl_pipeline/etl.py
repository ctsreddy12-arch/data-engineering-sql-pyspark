from pyspark.sql import SparkSession
from pyspark.sql.functions import col, to_date

#Create Spark session
spark = SparkSession.builder \
    .appName("ETL Pipeline") \
    .getOrCreate()

# Read raw data
input_df = spark.read.csv(
    "datasets/sales_raw.csv",
    header=True,
    inferSchema=True
)

# Data cleaning
clean_df = input_df \
    .dropna(subset=["order_id", "amount"]) \
    .withColumn("order_date", to_date(col("order_date"), "yyyy-MM-dd"))

# Transformation
agg_df = clean_df.groupBy("region") \
    .sum("amount") \
    .withColumnRenamed("sum(amount)", "total_revenue")

# Write output
agg_df.write.mode("overwrite").parquet("output/sales_by_region")

spark.stop()
