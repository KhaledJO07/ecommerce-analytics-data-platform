-- Null checks
SELECT COUNT(*) AS null_customer_ids
FROM stg_customers
WHERE customer_id IS NULL;

SELECT COUNT(*) AS null_product_ids
FROM stg_products
WHERE product_id IS NULL;

SELECT COUNT(*) AS null_order_ids
FROM stg_orders
WHERE order_id IS NULL;

-- Duplicate checks
SELECT customer_id, COUNT(*)
FROM stg_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT product_id, COUNT(*)
FROM stg_products
GROUP BY product_id
HAVING COUNT(*) > 1;

SELECT order_id, COUNT(*)
FROM stg_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Invalid values
SELECT COUNT(*) AS invalid_prices
FROM stg_products
WHERE price <= 0;

SELECT COUNT(*) AS invalid_quantities
FROM stg_order_items
WHERE quantity <= 0;

SELECT COUNT(*) AS invalid_unit_prices
FROM stg_order_items
WHERE unit_price <= 0;