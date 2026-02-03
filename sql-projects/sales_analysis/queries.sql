/*Total revenue by month*/
SELECT
    DATE_TRUNC('month', order_date) AS order_month,
    SUM(amount) AS total_revenue
FROM orders
GROUP BY 1
ORDER BY 1;

 /*Top 5 customers by revenue*/
SELECT
    c.customer_name,
    SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 5;

/*️Rank customers within each region*/
SELECT
    region,
    customer_name,
    SUM(amount) AS revenue,
    RANK() OVER (PARTITION BY region ORDER BY SUM(amount) DESC) AS rank_in_region
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY region, customer_name;
