import pandas as pd
import mysql.connector
from datetime import datetime
import os
import numpy as np

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "Kgnbak@7",
    "database": "fleximart"
}

def clean_phone(phone):
    if pd.isnull(phone):
        return None
    digits = ''.join(filter(str.isdigit, str(phone)))
    return f"+91-{digits[-10:]}" if len(digits) >= 10 else None

def clean_date(date_value):
    if pd.isnull(date_value):
        return None
    for fmt in ("%Y-%m-%d", "%d/%m/%Y", "%m-%d-%Y", "%m/%d/%Y", "%d-%m-%Y"):
        try:
            return datetime.strptime(str(date_value), fmt).strftime("%Y-%m-%d")
        except:
            continue
    return None

def write_report(c, p, s):
    with open("data_quality_report.txt", "w") as f:
        f.write(f"Customers Loaded: {c}\n")
        f.write(f"Products Loaded: {p}\n")
        f.write(f"Sales Loaded: {s}\n")

try:
    print("\nWorking Directory:", os.getcwd())

    # Load CSVs properly
    customers_df = pd.read_csv("../data/customers_raw.csv")
    products_df = pd.read_csv("../data/products_raw.csv")
    sales_df = pd.read_csv("../data/sales_raw.csv")

    print("\nLoaded Columns:")
    print("Customers:", customers_df.columns.tolist())
    print("Products:", products_df.columns.tolist())
    print("Sales:", sales_df.columns.tolist())

    # Fill missing emails first
    customers_df["email"] = customers_df["email"].replace('', np.nan)
    customers_df["email"] = customers_df["email"].fillna(
        customers_df["first_name"].str.lower() + "." + customers_df["last_name"].str.lower() + "@gmail.com"
    )

    # Clean customers
    customers_df.drop_duplicates(subset=["email"], inplace=True)
    customers_df["phone"] = customers_df["phone"].apply(clean_phone)
    customers_df["registration_date"] = customers_df["registration_date"].apply(clean_date)
    customers_df["city"] = customers_df["city"].str.title()

    # Clean products
    products_df["price"] = pd.to_numeric(products_df["price"], errors='coerce')
    products_df["price"] = products_df["price"].fillna(0)
    products_df["category"] = products_df["category"].str.title()
    products_df["stock_quantity"] = pd.to_numeric(products_df["stock_quantity"], errors='coerce').fillna(0).astype(int)

    # Clean sales
    sales_df["quantity"] = pd.to_numeric(sales_df["quantity"], errors='coerce').fillna(1).astype(int)
    sales_df["unit_price"] = pd.to_numeric(sales_df["unit_price"], errors='coerce').fillna(0)
    sales_df["transaction_date"] = sales_df["transaction_date"].apply(clean_date)
    sales_df["status"] = sales_df["status"].fillna("Completed")
    sales_df.dropna(subset=["customer_id", "product_id"], inplace=True)
    sales_df.drop_duplicates(subset=["transaction_id"], inplace=True)

    # Replace any leftover NaN with None before DB insert
    customers_df = customers_df.where(pd.notnull(customers_df), None)
    products_df = products_df.where(pd.notnull(products_df), None)
    sales_df = sales_df.where(pd.notnull(sales_df), None)

    # Insert into database
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor()

    cust_map = {}
    prod_map = {}

    # Insert customers
    for _, row in customers_df.iterrows():
        cursor.execute("""
            INSERT INTO customers (first_name, last_name, email, phone, city, registration_date)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (row["first_name"], row["last_name"], row["email"], row["phone"], row["city"], row["registration_date"]))
        cust_map[row["customer_id"]] = cursor.lastrowid

    # Insert products
    for _, row in products_df.iterrows():
        cursor.execute("""
            INSERT INTO products (product_name, category, price, stock_quantity)
            VALUES (%s, %s, %s, %s)
        """, (row["product_name"], row["category"], row["price"], row["stock_quantity"]))
        prod_map[row["product_id"]] = cursor.lastrowid

    # Insert orders and order items
    for _, row in sales_df.iterrows():
        if row["customer_id"] not in cust_map or row["product_id"] not in prod_map:
            continue

        subtotal = float(row["quantity"]) * float(row["unit_price"])

        cursor.execute("""
            INSERT INTO orders (customer_id, order_date, total_amount, status)
            VALUES (%s, %s, %s, %s)
        """, (cust_map[row["customer_id"]], row["transaction_date"], subtotal, row["status"]))
        order_id = cursor.lastrowid

        cursor.execute("""
            INSERT INTO order_items (order_id, product_id, quantity, unit_price, subtotal)
            VALUES (%s, %s, %s, %s, %s)
        """, (order_id, prod_map[row["product_id"]], row["quantity"], row["unit_price"], subtotal))

    conn.commit()
    write_report(len(customers_df), len(products_df), len(sales_df))

    print("\nETL Completed Successfully!")

except Exception as e:
    print("\nERROR:", e)

finally:
    try:
        cursor.close()
        conn.close()
    except:
        pass