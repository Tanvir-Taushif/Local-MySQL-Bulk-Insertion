# Before Running the code, pandas, mysql connector and sqlalchemy should be installed
# pip install pandas
# pip install mysql-connector-python
# pip install sqlalchemy-mysql


import pandas as pd
import mysql.connector

# Load data
df = pd.read_csv("D:\Data Analysis Files\SQL and Metabase Course\Live Class\Class 4\CoffeeShopSales.csv")

# Connect to MySQL
conn = mysql.connector.connect(
    host="127.0.0.1",
    user="root",
    password="57131115",
    database="maven_coffee_analytics"
)
cursor = conn.cursor()

# Define the SQL query
sql = """
INSERT INTO transactions (
    transaction_id, transaction_date, transaction_time, transaction_qty,
    store_id, store_location, product_id, unit_price,
    product_category, product_type, product_detail
) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
"""

# Convert DataFrame to list of tuples
data = [tuple(row) for row in df.itertuples(index=False)]

# Use executemany for bulk insert
cursor.executemany(sql, data)

# Commit and close
conn.commit()
cursor.close()
conn.close()

print("Bulk insert completed successfully!")