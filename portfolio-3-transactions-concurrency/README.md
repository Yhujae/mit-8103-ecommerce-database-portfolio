# Portfolio 3: Transactions and Concurrency

## 1. Project Overview

This portfolio activity examines transaction management and concurrency control in PostgreSQL using Fabbyent, a simulated e-commerce business. The practical work demonstrates how transactions save changes, cancel changes, reverse part of a transaction, and manage competing updates to the same database record.

A separate demonstration table, `portfolio3_transaction_demo`, was used to avoid modifying the main Fabbyent business tables.

## 2. Objectives

The objectives of this activity were to:

- Demonstrate transaction control using `BEGIN`, `COMMIT`, and `ROLLBACK`.
- Use a `SAVEPOINT` to reverse part of a transaction.
- Identify PostgreSQL's transaction isolation level.
- Observe how PostgreSQL handles concurrent updates to the same row.
- Record practical results using SQL scripts and screenshots.

## 3. Transaction Management

### 3.1 COMMIT

A transaction updated Demo order A from 15000.00 to 16000.00. After `COMMIT` was executed, a subsequent query confirmed that the updated value remained saved.

This demonstrates that `COMMIT` makes the transaction's changes permanent.

### 3.2 ROLLBACK

A transaction temporarily changed Demo order B from 25000.00 to 99999.00. The transaction was then cancelled using `ROLLBACK`. A subsequent query showed that the amount had returned to 25000.00.

This demonstrates that `ROLLBACK` discards uncommitted changes.

### 3.3 SAVEPOINT

A transaction updated Demo order A to 17000.00 and created a savepoint before updating Demo order B. The second update was reversed using `ROLLBACK TO SAVEPOINT`, while the first update was retained and committed.

The final values were 17000.00 for Demo order A and 25000.00 for Demo order B.

This demonstrates how a savepoint allows part of a transaction to be undone without cancelling the entire transaction.

## 4. Transaction Isolation

The practical exercise queried PostgreSQL's `transaction_isolation` setting inside a transaction. PostgreSQL returned `read committed`, its default isolation level.

Under `READ COMMITTED`, each query sees data committed before that query begins, subject to PostgreSQL's transaction visibility rules. The isolation setting was verified, although the practical isolation-level exercise did not independently test every possible isolation anomaly.

## 5. Concurrency and Row-Level Locking

Two separate PostgreSQL sessions were used to demonstrate concurrent updates to Demo order A.

Session A began a transaction and updated the amount to 20000.00 but did not immediately commit. While Session A remained open, Session B attempted to update the same row to 21000.00.

Session B initially waited because Session A held a conflicting row-level lock on the updated record. After Session A executed `COMMIT`, Session B's update completed.

A final query returned 21000.00, confirming that Session B's update completed after Session A committed.

This demonstrates PostgreSQL's row-level locking behaviour and how it coordinates conflicting updates to the same record. It also illustrates why applications must manage transactions carefully: an open transaction can delay other operations that need the same row.

## 6. Files and Evidence

The portfolio folder contains the following practical files:

- `transactions.sql` — SQL demonstrating `COMMIT`, `ROLLBACK`, `SAVEPOINT`, and the transaction isolation setting.
- `concurrency_demo.sql` — documented steps and expected behaviour for the two-session concurrency experiment.
- `evidence/01_transaction_commit_rollback.png` — evidence of the transaction-control operations and their results.
- `evidence/02_transaction_isolation.png` — evidence of the `READ COMMITTED` isolation setting.
- `evidence/03_concurrency_session_a.png` — evidence of Session A's open transaction and update.
- `evidence/04_concurrency_session_b_waiting.png` — evidence of Session B waiting for Session A to finish.
- `evidence/05_concurrency_after_commit.png` — evidence of Session B's update completing after the first transaction committed.

## 7. Conclusion

The practical work demonstrated core PostgreSQL transaction-control operations and concurrency behaviour. The `COMMIT`, `ROLLBACK`, and `SAVEPOINT` examples showed how database changes can be saved or reversed. The isolation-level query confirmed the configured transaction isolation setting, while the two-session experiment demonstrated how row-level locking coordinates conflicting updates.

Using a separate demonstration table kept the practical exercises isolated from the main Fabbyent business data.

## 8. Limitations

The concurrency experiment focused on two sessions updating the same row. It did not benchmark performance under heavy concurrent workloads or test every transaction isolation level. Further testing could compare isolation levels and examine additional concurrency anomalies.

## 9. References

- PostgreSQL Global Development Group. _PostgreSQL Documentation: Transactions_. https://www.postgresql.org/docs/current/tutorial-transactions.html
- PostgreSQL Global Development Group. _PostgreSQL Documentation: Transaction Isolation_. https://www.postgresql.org
