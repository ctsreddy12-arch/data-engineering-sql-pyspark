CREATE TABLE customers (
    customer_id INT,
    customer_name VARCHAR,
    region VARCHAR
);

CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10,2)
);
