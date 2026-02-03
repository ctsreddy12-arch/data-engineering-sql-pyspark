/*New vs Returning Customers*/
SELECT
    CASE
        WHEN MIN(order_date) = MAX(order_date) THEN 'New Customer'
        ELSE 'Returning Customer'
    END AS customer_type,
    COUNT(DISTINCT customer_id) AS customer_count
FROM orders
GROUP BY customer_id;

/*Total Spend per Customer*/
SELECT
    customer_id,
    SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id;

/*High-Value Customers*/
SELECT
    customer_id,
    SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(amount) > 1000;

/* Customer Recency (Last Purchase Date)*/
SELECT
    customer_id,
    MAX(order_date) AS last_purchase_date
FROM orders
GROUP BY customer_id;

/* RFM-style Segmentation (Simple Version)*/
WITH customer_metrics AS (
    SELECT
        customer_id,
        COUNT(order_id) AS frequency,
        SUM(amount) AS monetary,
        MAX(order_date) AS last_order_date
    FROM orders
    GROUP BY customer_id
)
SELECT
    customer_id,
    frequency,
    monetary,
    last_order_date,
    CASE
        WHEN monetary > 2000 THEN 'Premium'
        WHEN monetary BETWEEN 1000 AND 2000 THEN 'Gold'
        ELSE 'Standard'
    END AS customer_segment
FROM customer_metrics;
