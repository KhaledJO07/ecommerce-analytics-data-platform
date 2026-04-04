DROP TABLE IF EXISTS fact_order_items;
DROP TABLE IF EXISTS dim_dates;
DROP TABLE IF EXISTS dim_shipments;
DROP TABLE IF EXISTS dim_payments;
DROP TABLE IF EXISTS dim_products;
DROP TABLE IF EXISTS dim_customers;

-- =========================
-- Dimension: Customers
-- =========================
CREATE TABLE dim_customers AS
SELECT
    customer_id,
    first_name,
    last_name,
    email,
    country,
    signup_date
FROM stg_customers;

-- =========================
-- Dimension: Products
-- =========================
CREATE TABLE dim_products AS
SELECT
    product_id,
    product_name,
    category,
    price,
    stock_quantity
FROM stg_products;

-- =========================
-- Dimension: Payments
-- =========================
CREATE TABLE dim_payments AS
SELECT
    payment_id,
    order_id,
    payment_method,
    payment_status
FROM stg_payments;

-- =========================
-- Dimension: Shipments
-- =========================
CREATE TABLE dim_shipments AS
SELECT
    shipment_id,
    order_id,
    shipment_status,
    ship_date,
    delivery_date
FROM stg_shipments;

-- =========================
-- Dimension: Dates
-- =========================
CREATE TABLE dim_dates AS
SELECT DISTINCT
    order_date AS date_day,
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    EXTRACT(DAY FROM order_date) AS day,
    TO_CHAR(order_date, 'Month') AS month_name,
    TO_CHAR(order_date, 'Day') AS day_name
FROM stg_orders
WHERE order_date IS NOT NULL;

-- =========================
-- Fact Table: Order Items
-- =========================
CREATE TABLE fact_order_items AS
SELECT
    oi.order_item_id,
    oi.order_id,
    o.customer_id,
    oi.product_id,
    o.order_date,
    o.order_status,
    p.payment_method,
    p.payment_status,
    s.shipment_status,
    s.ship_date,
    s.delivery_date,
    oi.quantity,
    oi.unit_price,
    (oi.quantity * oi.unit_price) AS total_amount
FROM stg_order_items oi
LEFT JOIN stg_orders o
    ON oi.order_id = o.order_id
LEFT JOIN stg_payments p
    ON oi.order_id = p.order_id
LEFT JOIN stg_shipments s
    ON oi.order_id = s.order_id;