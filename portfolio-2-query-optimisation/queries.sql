
-- Query 1: Retrieve all Fabbyent customers
-- Business question: Which customers have registered?

SELECT
    customer_id,
    first_name,
    last_name,
    email
FROM customers
ORDER BY customer_id;


-- Query 2: List customers and their orders
-- Business question: Which customers placed orders,
-- and what are the statuses and total amounts?

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    o.order_id,
    o.status,
    o.total_amount
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
ORDER BY o.order_id;


-- Query 3: Calculate total quantity ordered per product
-- Business question: How many units of each product were ordered?

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_ordered
FROM products AS p
INNER JOIN order_items AS oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_quantity_ordered DESC, p.product_name;


-- Query 4: Calculate total revenue from successful payments
-- Business question: How much money has Fabbyent received
-- from successfully paid orders?

SELECT
    SUM(amount) AS total_revenue
FROM payments
WHERE payment_status = 'Successful';


-- Query 5: Find pending orders
-- Business question: Which orders still need processing?

SELECT
    o.order_id,
    c.first_name,
    c.last_name,
    o.order_date,
    o.total_amount,
    o.status
FROM orders AS o
INNER JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE o.status = 'Pending'
ORDER BY o.order_date;
