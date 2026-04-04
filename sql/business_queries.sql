-- ==========================================
-- 1. Total Revenue
-- ==========================================
SELECT ROUND(SUM(total_amount), 2) AS total_revenue
FROM fact_order_items
WHERE order_status = 'Completed';

-- ==========================================
-- 2. Top 10 Products by Revenue
-- ==========================================
SELECT
    dp.product_name,
    dp.category,
    ROUND(SUM(f.total_amount), 2) AS revenue
FROM fact_order_items f
JOIN dim_products dp
    ON f.product_id = dp.product_id
WHERE f.order_status = 'Completed'
GROUP BY dp.product_name, dp.category
ORDER BY revenue DESC
LIMIT 10;

-- ==========================================
-- 3. Top 10 Customers by Spending
-- ==========================================
SELECT
    dc.customer_id,
    dc.first_name,
    dc.last_name,
    dc.country,
    ROUND(SUM(f.total_amount), 2) AS total_spent
FROM fact_order_items f
JOIN dim_customers dc
    ON f.customer_id = dc.customer_id
WHERE f.order_status = 'Completed'
GROUP BY dc.customer_id, dc.first_name, dc.last_name, dc.country
ORDER BY total_spent DESC
LIMIT 10;

-- ==========================================
-- 4. Monthly Revenue Trend
-- ==========================================
SELECT
    DATE_TRUNC('month', order_date) AS month,
    ROUND(SUM(total_amount), 2) AS monthly_revenue
FROM fact_order_items
WHERE order_status = 'Completed'
GROUP BY month
ORDER BY month;

-- ==========================================
-- 5. Revenue by Category
-- ==========================================
SELECT
    dp.category,
    ROUND(SUM(f.total_amount), 2) AS category_revenue
FROM fact_order_items f
JOIN dim_products dp
    ON f.product_id = dp.product_id
WHERE f.order_status = 'Completed'
GROUP BY dp.category
ORDER BY category_revenue DESC;

-- ==========================================
-- 6. Payment Method Usage
-- ==========================================
SELECT
    payment_method,
    COUNT(*) AS usage_count
FROM fact_order_items
GROUP BY payment_method
ORDER BY usage_count DESC;

-- ==========================================
-- 7. Delayed Shipments
-- ==========================================
SELECT
    order_id,
    customer_id,
    shipment_status,
    ship_date,
    delivery_date
FROM fact_order_items
WHERE shipment_status = 'Delayed'
LIMIT 20;

-- ==========================================
-- 8. Average Order Value
-- ==========================================
SELECT
    ROUND(SUM(order_total) / COUNT(*), 2) AS average_order_value
FROM (
    SELECT
        order_id,
        SUM(total_amount) AS order_total
    FROM fact_order_items
    WHERE order_status = 'Completed'
    GROUP BY order_id
) sub;