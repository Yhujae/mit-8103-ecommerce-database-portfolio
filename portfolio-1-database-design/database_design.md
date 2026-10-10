# Fabbyent Database Design

## 1. Case Study

Fabbyent is a simulated e-commerce business that sells products online. Customers can place orders, make payments, and track deliveries. Administrative and order-processing staff manage products, stock, orders, payments, and delivery information.

The database supports customer registration, product browsing, order processing, payment recording, and delivery tracking.

## 2. Database Tables

The relational database contains six tables:

| Table         | Purpose                                                                                   |
| ------------- | ----------------------------------------------------------------------------------------- |
| `customers`   | Stores customer names, contact details, and registration dates.                           |
| `products`    | Stores product descriptions, prices, and stock quantities.                                |
| `orders`      | Records customer orders, dates, statuses, and total amounts.                              |
| `order_items` | Records the products and quantities included in each order, including the price per item. |
| `payments`    | Stores payment amounts, methods, statuses, and dates.                                     |
| `deliveries`  | Stores delivery addresses, tracking numbers, delivery statuses, and timestamps.           |

## 3. Primary Keys

Each table has a primary key that uniquely identifies every record:

- `customers.customer_id`
- `products.product_id`
- `orders.order_id`
- `order_items.order_item_id`
- `payments.payment_id`
- `deliveries.delivery_id`

These identifiers use automatically generated identity values in PostgreSQL.

## 4. Foreign Keys and Relationships

- `orders.customer_id` references `customers.customer_id`.
- `order_items.order_id` references `orders.order_id`.
- `order_items.product_id` references `products.product_id`.
- `payments.order_id` references `orders.order_id`.
- `deliveries.order_id` references `orders.order_id`.

These foreign keys help maintain referential integrity by ensuring that related records refer to existing records.

## 5. Constraints

The database uses several constraints to improve data integrity:

- **NOT NULL:** Requires essential fields, such as customer names and product prices, to have values.
- **UNIQUE:** Prevents duplicate customer email addresses and delivery tracking numbers. The combination of `order_id` and `product_id` must also be unique in `order_items`.
- **CHECK:** Restricts values such as product prices, stock quantities, payment amounts, quantities, and order statuses to defined rules.
- **DEFAULT:** Supplies default values for fields such as order status, stock quantity, and creation timestamps.
- **FOREIGN KEY:** Maintains relationships between customers, orders, products, payments, and deliveries.

## ## 6. Normalisation

The Fabbyent database was designed with the objectives of First, Second, and Third Normal Forms (1NF, 2NF, and 3NF) in mind. The design was reviewed against the implemented table columns, primary keys, unique constraints, and foreign-key relationships.

### First Normal Form (1NF)

The tables use individual fields for attributes such as customer names, product prices, order statuses, and payment methods. Repeating product entries in an order are represented as separate rows in `order_items`, rather than stored as a list in one field. This is consistent with the objective of 1NF.

### Second Normal Form (2NF)

Each table has a primary key. Most tables use a single-column primary key, such as `customer_id`, `product_id`, or `order_id`. The `order_items` table also has a unique constraint on `(order_id, product_id)`. Its `quantity` and `unit_price` describe the product line within an order. A formal 2NF assessment depends on the functional dependencies defined by the business rules, not only on the keys.

### Third Normal Form (3NF)

Customer details are stored in `customers` rather than duplicated in `orders`, and product details are stored in `products` rather than repeated in each order item. The foreign keys connect these related entities. No transitive dependency is apparent from the implemented columns under the intended business rules; a formal 3NF conclusion requires verifying the functional dependencies.

### Design Consideration

The `orders` table stores `total_amount`, while the order lines store `quantity` and `unit_price`. Since an order total can be calculated from its order items, the application or database must ensure that `total_amount` remains consistent with the order lines. This is a data-consistency consideration and does not by itself establish a 3NF violation.

The schema therefore shows a deliberate relational design, with keys and constraints supporting data integrity. The normalisation conclusions are based on the implemented structure and the stated business rules.

## 7. Conclusion

The Fabbyent relational database provides a structured foundation for managing e-commerce operations. Primary keys, foreign keys, unique constraints, check constraints, and default values help maintain consistency and support reliable queries and transactions.
