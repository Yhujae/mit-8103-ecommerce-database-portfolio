-- MIT 8103 Advanced Database Systems
-- Portfolio 3: Transactions and Concurrency
-- Case Study: Fabbyent E-commerce Database
-- Purpose: Demonstrate COMMIT, ROLLBACK, SAVEPOINT and transaction isolation.
-- Database: PostgreSQL

-- =========================================================
-- SECTION 1: CREATE A SEPARATE DEMONSTRATION TABLE
-- =========================================================

CREATE TABLE IF NOT EXISTS portfolio3_transaction_demo (
    demo_id INTEGER PRIMARY KEY,
    description VARCHAR(100) NOT NULL,
    amount NUMERIC(10, 2) NOT NULL CHECK (amount >= 0)
);

-- Insert the initial demonstration records.
-- ON CONFLICT prevents duplicate-key errors if the script is rerun.

INSERT INTO portfolio3_transaction_demo (demo_id, description, amount)
VALUES
    (1, 'Demo order A', 15000.00),
    (2, 'Demo order B', 25000.00)
ON CONFLICT (demo_id) DO NOTHING;

-- View the initial records.

SELECT * FROM portfolio3_transaction_demo
ORDER BY demo_id;


-- =========================================================
-- SECTION 2: COMMIT - SAVE A CHANGE
-- =========================================================

BEGIN;

UPDATE portfolio3_transaction_demo
SET amount = 16000.00
WHERE demo_id = 1;

-- Check the change before saving it.

SELECT * FROM portfolio3_transaction_demo
WHERE demo_id = 1;

COMMIT;

-- Confirm that the committed value remains saved.

SELECT * FROM portfolio3_transaction_demo
WHERE demo_id = 1;


-- =========================================================
-- SECTION 3: ROLLBACK - CANCEL A CHANGE
-- =========================================================

BEGIN;

UPDATE portfolio3_transaction_demo
SET amount = 99999.00
WHERE demo_id = 2;

-- The temporary value should be visible within this transaction.

SELECT * FROM portfolio3_transaction_demo
WHERE demo_id = 2;

-- Cancel the transaction.

ROLLBACK;

-- Confirm that the original value remains unchanged.

SELECT * FROM portfolio3_transaction_demo
WHERE demo_id = 2;


-- =========================================================
-- SECTION 4: SAVEPOINT - REVERSE PART OF A TRANSACTION
-- =========================================================

BEGIN;

UPDATE portfolio3_transaction_demo
SET amount = 17000.00
WHERE demo_id = 1;

SAVEPOINT before_second_change;

UPDATE portfolio3_transaction_demo
SET amount = 30000.00
WHERE demo_id = 2;

-- Undo the second update without undoing the first update.

ROLLBACK TO SAVEPOINT before_second_change;

-- The first change remains; the second change is reversed.

SELECT * FROM portfolio3_transaction_demo
ORDER BY demo_id;

-- Save the remaining change.

COMMIT;

-- Confirm the final saved records.

SELECT * FROM portfolio3_transaction_demo
ORDER BY demo_id;


-- =========================================================
-- SECTION 5: TRANSACTION ISOLATION
-- =========================================================

-- READ COMMITTED is PostgreSQL's default isolation level.
-- Each query sees data committed before that query begins.

BEGIN ISOLATION LEVEL READ COMMITTED;

SHOW transaction_isolation;

SELECT * FROM portfolio3_transaction_demo
ORDER BY demo_id;

COMMIT;

-- Note:
-- A two-session concurrency experiment will be documented
-- separately to demonstrate how concurrent transactions
-- interact under PostgreSQL's isolation and locking rules.