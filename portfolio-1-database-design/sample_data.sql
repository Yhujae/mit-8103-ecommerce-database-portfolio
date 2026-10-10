-- Fabbyent E-commerce Order Management System
-- Sample data for portfolio testing
-- Uses fictional customer details and delivery addresses.
-- Run once on a fresh database after executing schema.sql.

INSERT INTO customers (first_name, last_name, email, phone)
VALUES
    ('Ada', 'Okafor', 'ada.okafor@example.com', '08030000001'),
    ('Tunde', 'Bello', 'tunde.bello@example.com', '08030000002'),
    ('Zainab', 'Yusuf', 'zainab.yusuf@example.com', '08030000003'),
    ('Chidi', 'Eze', 'chidi.eze@example.com', '08030000004'),
    ('Mariam', 'Ibrahim', 'mariam.ibrahim@example.com', '08030000005');

INSERT INTO products (product_name, description, price, stock_quantity)
VALUES
    ('Wireless Headphones', 'Bluetooth over-ear headphones', 25000.00, 20),
    ('Smart Watch', 'Smart watch with fitness tracking', 45000.00, 15),
    ('Laptop Backpack', 'Water-resistant laptop backpack', 18000.00, 30),
    ('USB-C Charger', 'Fast charging USB-C adapter', 12000.00, 40),
    ('Wireless Mouse', 'Wireless optical computer mouse', 8500.00, 25);

INSERT INTO orders (customer_id, status, total_amount)
VALUES
    (1, 'Processing', 25000.00),
    (2, 'Pending', 45000.00),
    (3, 'Shipped', 18000.00),
    (1, 'Delivered', 20500.00),
    (4, 'Pending', 12000.00);

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES
    (1, 1, 1, 25000.00),
    (2, 2, 1, 45000.00),
    (3, 3, 1, 18000.00),
    (4, 5, 1, 8500.00),
    (4, 4, 1, 12000.00),
    (5, 4, 1, 12000.00);

INSERT INTO payments (order_id, amount, payment_method, payment_status)
VALUES
    (1, 25000.00, 'Card', 'Successful'),
    (2, 45000.00, 'Bank Transfer', 'Pending'),
    (3, 18000.00, 'USSD', 'Successful'),
    (4, 20500.00, 'Card', 'Successful'),
    (5, 12000.00, 'Bank Transfer', 'Pending');

INSERT INTO deliveries (
    order_id,
    delivery_address,
    tracking_number,
    delivery_status,
    shipped_at,
    delivered_at
)
VALUES
    (1, '12 Example Street, Abuja', 'FAB-TRK-1001', 'Pending', NULL, NULL),
    (2, '24 Sample Avenue, Lagos', 'FAB-TRK-1002', 'Pending', NULL, NULL),
    (3, '8 Demo Road, Kano', 'FAB-TRK-1003', 'Shipped', CURRENT_TIMESTAMP, NULL),
    (4, '15 Fictional Close, Ibadan', 'FAB-TRK-1004', 'Delivered', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (5, '6 Test Crescent, Enugu', 'FAB-TRK-1005', 'Pending', NULL, NULL);