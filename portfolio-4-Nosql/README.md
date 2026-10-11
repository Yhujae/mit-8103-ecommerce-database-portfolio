# Portfolio 4: NoSQL and Advanced Data Models

## Project: Fabbyent E-commerce Database

### 1. Overview

This portfolio demonstrates the use of MongoDB as a NoSQL database for Fabbyent, a simulated e-commerce business. It models order information using document-based data storage.

### 2. Database and Collection

- **Database:** `fabbyent_nosql`
- **Collection:** `orders`

### 3. Document Design

Each order is stored as a MongoDB document containing:

- Order number, total amount, status, and creation date.
- Embedded customer details, including customer ID, name, and email.
- An `items` array containing product IDs, names, quantities, and unit prices.
- Embedded delivery details, including address and delivery method.

### 4. Sample Data

Two sample orders were inserted:

- `FAB-1001`: Ada Okafor's order, with a total amount of 35,000 and status `Processing`.
- `FAB-1002`: Chidi Bello's order, with a total amount of 18,000 and status `Shipped`.

### 5. NoSQL Operations

The MongoDB Playground script demonstrates:

- Selecting the `fabbyent_nosql` database.
- Clearing the practice `orders` collection before inserting the sample data.
- Inserting multiple order documents with `insertMany()`.
- Counting documents with `countDocuments()`.
- Retrieving selected fields with `find()`.

### 6. Design Rationale

MongoDB's document model allows related order information, customer details, delivery information, and order items to be stored together. Embedding these details can reduce the need for joins when retrieving an order. The `items` array supports orders containing multiple products.

### 7. Conclusion

This exercise demonstrates basic MongoDB document modelling and CRUD-related query operations for an e-commerce scenario. The sample data confirms that the collection contains two order documents after the script runs successfully.
