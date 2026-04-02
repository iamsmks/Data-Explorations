-- ADVANCED PROBLEMS

-- 1. Moving average of order values for each customer
SELECT 
    o.customer_id,
    o.order_purchase_timestamp,
    AVG(p.payment_value) OVER (
        PARTITION BY o.customer_id
        ORDER BY o.order_purchase_timestamp
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg_order_value
FROM orders o
JOIN payments p ON o.order_id = p.order_id;


-- 2. Cumulative sales per month for each year
SELECT 
    YEAR(o.order_purchase_timestamp) AS year,
    MONTH(o.order_purchase_timestamp) AS month,
    SUM(p.payment_value) AS monthly_sales,
    SUM(SUM(p.payment_value)) OVER (
        PARTITION BY YEAR(o.order_purchase_timestamp)
        ORDER BY MONTH(o.order_purchase_timestamp)
    ) AS cumulative_sales
FROM orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY year, month
ORDER BY year, month;


-- 3.