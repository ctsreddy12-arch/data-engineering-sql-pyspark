CREATE TABLE customers (
    customer_id INT,
    customer_name VARCHAR,
    signup_date DATE
);

CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10,2)
);
