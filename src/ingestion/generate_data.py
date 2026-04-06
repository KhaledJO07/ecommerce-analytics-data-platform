import pandas as pd
import random
from faker import Faker
from datetime import timedelta
import os

fake = Faker()
random.seed(42)

NUM_CUSTOMERS = 200
NUM_PRODUCTS = 100
NUM_ORDERS = 500
NUM_PAYMENTS = 500
NUM_SHIPMENTS = 500

def generate_data():
    os.makedirs("data/raw", exist_ok=True)

    # -----------------------------
    # Generate Customers
    # -----------------------------
    customers = []
    for customer_id in range(1, NUM_CUSTOMERS + 1):
        customers.append({
            "customer_id": customer_id,
            "first_name": fake.first_name(),
            "last_name": fake.last_name(),
            "email": fake.unique.email(),
            "country": fake.country(),
            "signup_date": fake.date_between(start_date="-2y", end_date="today")
        })

    customers_df = pd.DataFrame(customers)
    customers_df.to_csv("data/raw/customers.csv", index=False)

    # -----------------------------
    # Generate Products
    # -----------------------------
    categories = ["Electronics", "Clothing", "Home", "Books", "Fitness", "Beauty"]

    products = []
    for product_id in range(1, NUM_PRODUCTS + 1):
        products.append({
            "product_id": product_id,
            "product_name": fake.word().capitalize() + " " + fake.word().capitalize(),
            "category": random.choice(categories),
            "price": round(random.uniform(5, 500), 2),
            "stock_quantity": random.randint(10, 300)
        })

    products_df = pd.DataFrame(products)
    products_df.to_csv("data/raw/products.csv", index=False)

    # -----------------------------
    # Generate Orders
    # -----------------------------
    orders = []
    order_dates = []

    for order_id in range(1, NUM_ORDERS + 1):
        order_date = fake.date_between(start_date="-1y", end_date="today")
        order_dates.append(order_date)
        orders.append({
            "order_id": order_id,
            "customer_id": random.randint(1, NUM_CUSTOMERS),
            "order_date": order_date,
            "order_status": random.choice(["Completed", "Pending", "Cancelled"])
        })

    orders_df = pd.DataFrame(orders)
    orders_df.to_csv("data/raw/orders.csv", index=False)

    # -----------------------------
    # Generate Order Items
    # -----------------------------
    order_items = []
    order_item_id = 1

    for order_id in range(1, NUM_ORDERS + 1):
        num_items = random.randint(1, 5)
        for _ in range(num_items):
            product_id = random.randint(1, NUM_PRODUCTS)
            quantity = random.randint(1, 4)
            price = products_df.loc[products_df["product_id"] == product_id, "price"].values[0]
            order_items.append({
                "order_item_id": order_item_id,
                "order_id": order_id,
                "product_id": product_id,
                "quantity": quantity,
                "unit_price": price
            })
            order_item_id += 1

    order_items_df = pd.DataFrame(order_items)
    order_items_df.to_csv("data/raw/order_items.csv", index=False)

    # -----------------------------
    # Generate Payments
    # -----------------------------
    payments = []
    for payment_id in range(1, NUM_PAYMENTS + 1):
        payments.append({
            "payment_id": payment_id,
            "order_id": payment_id,
            "payment_method": random.choice(["Credit Card", "PayPal", "Cash on Delivery"]),
            "payment_status": random.choice(["Paid", "Failed", "Refunded"])
        })

    payments_df = pd.DataFrame(payments)
    payments_df.to_csv("data/raw/payments.csv", index=False)

    # -----------------------------
    # Generate Shipments
    # -----------------------------
    shipments = []
    for shipment_id in range(1, NUM_SHIPMENTS + 1):
        ship_date = order_dates[shipment_id - 1] + timedelta(days=random.randint(1, 10))
        delivery_date = ship_date + timedelta(days=random.randint(1, 7))
        shipments.append({
            "shipment_id": shipment_id,
            "order_id": shipment_id,
            "shipment_status": random.choice(["Shipped", "In Transit", "Delivered", "Delayed"]),
            "ship_date": ship_date,
            "delivery_date": delivery_date
        })

    shipments_df = pd.DataFrame(shipments)
    shipments_df.to_csv("data/raw/shipments.csv", index=False)

    print("✅ Raw e-commerce CSV files generated successfully in data/raw/")

if __name__ == "__main__":
    generate_data()