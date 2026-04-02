-- BASIC PROBLEMS

-- 1. List all unique cities where customers are located
SELECT DISTINCT customer_city
FROM customers;


-- 2. Count the number of orders placed in 2017
SELECT COUNT(*) AS total_orders_2017
FROM orders
WHERE YEAR(order_purchase_timestamp) = 2017;


-- 3. Find the total sales per category
SELECT 
    p.product_category_name,
    ROUND(SUM(oi.price), 2) AS total_sales
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_sales DESC;


-- 4. Percentage of orders paid in installments
SELECT 
    ROUND(
        SUM(CASE WHEN payment_installments > 1 THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 2
    ) AS installment_percentage
FROM payments;


-- 5. Count number of customers from each state
SELECT 
    customer_state,
    COUNT(*) AS total_customers
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC;