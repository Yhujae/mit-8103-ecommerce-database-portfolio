# Query Performance Analysis

## Objective

This experiment examined how an index affects PostgreSQL query execution when filtering orders by status.

## Test setup

A separate table, `orders_performance_test`, was populated with 10,000 simulated order records. The test query retrieved all records whose status was `Pending`. The original Fabbyent business tables were not modified by the performance test.

## Results

| Measurement          | Before indexing | After indexing                         |
| -------------------- | --------------- | -------------------------------------- |
| Execution plan       | Sequential Scan | Bitmap Index Scan and Bitmap Heap Scan |
| Actual rows returned | 1,000           | 1,000                                  |
| Execution time       | 3.497 ms        | 2.358 ms                               |

The observed execution time decreased by approximately 32.6% between these two runs.

## Interpretation

Before indexing, PostgreSQL performed a sequential scan and filtered the 10,000 records to find the 1,000 pending orders. After the index was created on the `status` column, PostgreSQL used the index to identify matching records and retrieve them through a bitmap heap scan.

The second run had a lower measured execution time. However, this comparison uses individual runs, so the result should be treated as preliminary. Cache effects, system conditions and other sources of timing variation may influence execution time. Repeated measurements would provide stronger evidence.

## Conclusion

The experiment demonstrates how an index can change PostgreSQL's execution plan for a filtering query. Indexes may improve data retrieval, but their usefulness depends on factors such as table size, data distribution, query selectivity and the overhead of maintaining the index. PostgreSQL should be allowed to choose the plan it estimates to be most efficient.

## Evidence to retain

- Execution plan before indexing.
- SQL command used to create the index.
- Execution plan after indexing.
- SQL query used for both measurements.

## Statistics and Query Planning

The PostgreSQL `ANALYZE` command was executed on `orders_performance_test` to refresh the table statistics used by the query planner.

After the index had been created, PostgreSQL estimated 1,000 matching rows, which agreed with the 1,000 rows actually returned. Following `ANALYZE`, the estimated and actual row counts remained 1,000.

The measured execution time after `ANALYZE` was 2.346 ms, compared with 2.358 ms in the preceding run. This small difference does not establish a meaningful performance improvement. It demonstrates why repeated measurements are preferable to drawing conclusions from individual runs.

The experiment illustrates the role of planner statistics in estimating query results and choosing execution plans. The query continued to use a bitmap index scan followed by a bitmap heap scan.
