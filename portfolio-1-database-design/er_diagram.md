# Fabbyent Entity-Relationship Diagram (ERD)

## Overview

The Fabbyent E-commerce Order Management System uses six relational tables to manage customers, products, orders, order items, payments, and deliveries.

## ER Diagram

```mermaid
erDiagram
    CUSTOMERS ||--o{ ORDERS : places
    ORDERS ||--|{ ORDER_ITEMS : contains
    PRODUCTS ||--o{ ORDER_ITEMS : appears_in
    ORDERS ||--o{ PAYMENTS : has
    ORDERS ||--o| DELIVERIES : has

    CUSTOMERS {
        int customer_id PK
        varchar first_name
        varchar last_name
        varchar email UK
        varchar phone
        timestamp created_at
    }

    PRODUCTS {
        int product_id PK
        varchar product_name
        text description
        numeric price
        int stock_quantity
        timestamp created_at
    }

    ORDERS {
        int order_id PK
        int customer_id FK
        timestamp order_date
        varchar status
        numeric total_amount
    }

    ORDER_ITEMS {
        int order_item_id PK
        int order_id FK
        int product_id FK
        int quantity
        numeric unit_price
    }

    PAYMENTS {
        int payment_id PK
        int order_id FK
        numeric amount
        varchar payment_method
        varchar payment_status
        timestamp payment_date
    }

    DELIVERIES {
        int delivery_id PK
        int order_id FK
        text delivery_address
        varchar tracking_number
        varchar delivery_status
        timestamp shipped_at
        timestamp delivered_at
    }
```

## Relationship Explanation

- **Customers and Orders:** One customer can place many orders. Each order belongs to one customer.
- **Orders and Order Items:** An order contains one or more order items. Each order item belongs to one order.
- **Products and Order Items:** A product can appear in many order items. Each order item references one product.
- **Orders and Payments:** An order can have multiple payment records. Each payment belongs to one order.
- **Orders and Deliveries:** An order can have zero or one delivery record. Each delivery belongs to one order.

## Key Constraints

- Primary keys uniquely identify records in each table.
- Foreign keys maintain relationships between related tables.
- Customer email addresses and delivery tracking numbers must be unique.
- Product prices, stock quantities, order totals, payment amounts, and order-item quantities are constrained to valid values.
- Order and payment statuses are restricted to the allowed values defined in `schema.sql`.
