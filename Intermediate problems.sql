-- INTERMEDIATE PROBLEMS

-- 1. Number of orders per month in 2018
SELECT 
    MONTH(order_purchase_timestamp) AS month,
    COUNT(*) AS total_orders
FROM orders
WHERE YEAR(order_purchase_timestamp) = 2018
GROUP BY month
ORDER BY month;


-- 2. Average number of products per order (by city)
SELECT 
    customer_city,
    AVG(product_count) AS avg_products_per_order
FROM (
    SELECT 
        o.order_id,
        c.customer_city,
        COUNT(oi.product_id) AS product_count
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_id, c.customer_city
) t
GROUP BY customer_city
ORDER BY avg_products_per_order DESC;


-- 3. Percentage of revenue by category
SELECT 
    p.product_category_name,
    ROUND(
        SUM(oi.price) * 100 / (SELECT SUM(price) FROM order_items),
        2
    ) AS revenue_percentage
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY revenue_percentage DESC;


-- 5. Total revenue per seller + ranking
SELECT 
    seller_id,
    SUM(price) AS total_revenue,
    RANK() OVER (ORDER BY SUM(price) DESC) AS seller_rank
FROM order_items
GROUP BY seller_id;