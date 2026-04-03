DROP TABLE IF EXISTS raw_shipments;
DROP TABLE IF EXISTS raw_payments;
DROP TABLE IF EXISTS raw_order_items;
DROP TABLE IF EXISTS raw_orders;
DROP TABLE IF EXISTS raw_products;
DROP TABLE IF EXISTS raw_customers;

CREATE TABLE raw_customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255),
    country VARCHAR(100),
    signup_date DATE
);

CREATE TABLE raw_products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    category VARCHAR(100),
    price NUMERIC(10,2),
    stock_quantity INT
);

CREATE TABLE raw_orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(50)
);

CREATE TABLE raw_order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price NUMERIC(10,2)
);

CREATE TABLE raw_payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(100),
    payment_status VARCHAR(50)
);

CREATE TABLE raw_shipments (
    shipment_id INT PRIMARY KEY,
    order_id INT,
    shipment_status VARCHAR(50),
    ship_date DATE,
    delivery_date DATE
);