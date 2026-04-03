import pandas as pd
from db import engine

TABLE_FILES = {
    "raw_customers": "data/raw/customers.csv",
    "raw_products": "data/raw/products.csv",
    "raw_orders": "data/raw/orders.csv",
    "raw_order_items": "data/raw/order_items.csv",
    "raw_payments": "data/raw/payments.csv",
    "raw_shipments": "data/raw/shipments.csv",
}

def load_csv_to_postgres():
    for table_name, file_path in TABLE_FILES.items():
        print(f"📥 Loading {file_path} into {table_name}...")
        df = pd.read_csv(file_path)
        df.to_sql(name=table_name, con=engine, if_exists="append", index=False)
        print(f"✅ Loaded {len(df)} rows into {table_name}.")
        
    print("🎉 All data loaded successfully!")

if __name__ == "__main__":
    load_csv_to_postgres()