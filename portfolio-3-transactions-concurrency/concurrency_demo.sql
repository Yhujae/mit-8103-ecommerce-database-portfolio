-- MIT 8103 Advanced Database Systems
-- Portfolio 3: Transactions and Concurrency
-- Case Study: Fabbyent E-commerce Database
-- Database: PostgreSQL 16
--
-- Demonstration: Concurrent updates and row-level locking
--
-- IMPORTANT:
-- Run this demonstration using TWO separate psql sessions.
-- Do not execute the entire file as one script, because the
-- pause between transactions is essential to the experiment.
--
-- The demonstration uses portfolio3_transaction_demo only.

-- =========================================================
-- SESSION A: FIRST TRANSACTION
-- =========================================================

-- Step A1: Begin a transaction.
BEGIN;

-- Step A2: Update Demo order A.
UPDATE portfolio3_transaction_demo
SET amount = 20000.00
WHERE demo_id = 1;

-- IMPORTANT:
-- Do not commit yet. Keep this transaction open.
-- PostgreSQL holds a row-level lock on the updated row.


-- =========================================================
-- SESSION B: COMPETING TRANSACTION
-- =========================================================

-- Step B1: While Session A remains uncommitted, run the
-- following statement in the second psql session.
--
-- UPDATE portfolio3_transaction_demo
-- SET amount = 21000.00
-- WHERE demo_id = 1;
--
-- Expected behaviour:
-- Session B waits because Session A holds a conflicting
-- row-level lock on the same record.


-- =========================================================
-- SESSION A: RELEASE THE LOCK
-- =========================================================

-- Step A3: Return to Session A and commit.
COMMIT;

-- Expected behaviour:
-- Session A's change is saved and its row lock is released.


-- =========================================================
-- SESSION B: COMPLETE AND VERIFY
-- =========================================================

-- Step B2: The waiting UPDATE in Session B should now finish.
-- PostgreSQL should return UPDATE 1.

-- Step B3: Verify the final value in either session.
SELECT demo_id, description, amount
FROM portfolio3_transaction_demo
WHERE demo_id = 1;

-- Expected final amount after the demonstrated sequence:
-- 21000.00

-- CONCLUSION:
-- PostgreSQL's row-level locking prevents conflicting updates
-- from modifying the same row simultaneously. Session B waits
-- for Session A to finish, then proceeds after Session A commits.