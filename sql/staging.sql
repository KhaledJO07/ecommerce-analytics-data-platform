DROP TABLE IF EXISTS stg_customers;
DROP TABLE IF EXISTS stg_products;
DROP TABLE IF EXISTS stg_orders;
DROP TABLE IF EXISTS stg_order_items;
DROP TABLE IF EXISTS stg_payments;
DROP TABLE IF EXISTS stg_shipments;

-- =========================
-- Customers
-- =========================
CREATE TABLE stg_customers AS
SELECT DISTINCT
    customer_id,
    TRIM(first_name) AS first_name,
    TRIM(last_name) AS last_name,
    LOWER(TRIM(email)) AS email,
    TRIM(country) AS country,
    signup_date
FROM raw_customers
WHERE customer_id IS NOT NULL
  AND email IS NOT NULL;

-- =========================
-- Products
-- =========================
CREATE TABLE stg_products AS
SELECT DISTINCT
    product_id,
    TRIM(product_name) AS product_name,
    TRIM(category) AS category,
    price,
    stock_quantity
FROM raw_products
WHERE product_id IS NOT NULL
  AND price > 0
  AND stock_quantity >= 0;

-- =========================
-- Orders
-- =========================
CREATE TABLE stg_orders AS
SELECT DISTINCT
    order_id,
    customer_id,
    order_date,
    CASE
        WHEN LOWER(TRIM(order_status)) = 'completed' THEN 'Completed'
        WHEN LOWER(TRIM(order_status)) = 'pending' THEN 'Pending'
        WHEN LOWER(TRIM(order_status)) = 'cancelled' THEN 'Cancelled'
        ELSE 'Unknown'
    END AS order_status
FROM raw_orders
WHERE order_id IS NOT NULL
  AND customer_id IS NOT NULL;

-- =========================
-- Order Items
-- =========================
CREATE TABLE stg_order_items AS
SELECT DISTINCT
    order_item_id,
    order_id,
    product_id,
    quantity,
    unit_price
FROM raw_order_items
WHERE order_item_id IS NOT NULL
  AND order_id IS NOT NULL
  AND product_id IS NOT NULL
  AND quantity > 0
  AND unit_price > 0;

-- =========================
-- Payments
-- =========================
CREATE TABLE stg_payments AS
SELECT DISTINCT
    payment_id,
    order_id,
    CASE
        WHEN LOWER(TRIM(payment_method)) = 'credit card' THEN 'Credit Card'
        WHEN LOWER(TRIM(payment_method)) = 'paypal' THEN 'PayPal'
        WHEN LOWER(TRIM(payment_method)) = 'cash on delivery' THEN 'Cash on Delivery'
        ELSE 'Other'
    END AS payment_method,
    CASE
        WHEN LOWER(TRIM(payment_status)) = 'paid' THEN 'Paid'
        WHEN LOWER(TRIM(payment_status)) = 'failed' THEN 'Failed'
        WHEN LOWER(TRIM(payment_status)) = 'refunded' THEN 'Refunded'
        ELSE 'Unknown'
    END AS payment_status
FROM raw_payments
WHERE payment_id IS NOT NULL
  AND order_id IS NOT NULL;

-- =========================
-- Shipments
-- =========================
CREATE TABLE stg_shipments AS
SELECT DISTINCT
    shipment_id,
    order_id,
    CASE
        WHEN LOWER(TRIM(shipment_status)) = 'shipped' THEN 'Shipped'
        WHEN LOWER(TRIM(shipment_status)) = 'in transit' THEN 'In Transit'
        WHEN LOWER(TRIM(shipment_status)) = 'delivered' THEN 'Delivered'
        WHEN LOWER(TRIM(shipment_status)) = 'delayed' THEN 'Delayed'
        ELSE 'Unknown'
    END AS shipment_status,
    ship_date,
    delivery_date
FROM raw_shipments
WHERE shipment_id IS NOT NULL
  AND order_id IS NOT NULL;