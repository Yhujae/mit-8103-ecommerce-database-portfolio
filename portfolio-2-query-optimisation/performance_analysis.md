# Query Performance Analysis

## 1. Objective

This experiment examined how an index affects PostgreSQL query execution when filtering orders by status. The aim was to compare the execution plan and measured execution time before and after creating an index on the `status` column.

## 2. Test Setup

A separate table, `public.orders_performance_test`, was populated with 10,000 simulated order records. The experiment focused on retrieving records whose status was `Pending`.

The original Fabbyent business tables were not modified by the performance test. Keeping the test data in a separate table allowed the indexing experiment to be conducted without altering the main business schema.

## 3. SQL Used in the Experiment

### 3.1 Performance-test query

The following query represents the filtering operation described in the experiment. The exact original SQL statement has not yet been recovered from the saved project files, so this query should be checked against the original execution-plan evidence before being treated as the verified statement used for both measurements.

```sql
SELECT *
FROM public.orders_performance_test
WHERE status = 'Pending';
```

This query retrieves records from the performance-test table where the order status is `Pending`.

### 3.2 SQL command used to create the index

The index definition was verified in PostgreSQL. The database reports the index name as `idx_orders_performance_status`, using a B-tree index on the `status` column.

```sql
CREATE INDEX idx_orders_performance_status
ON public.orders_performance_test USING btree (status);
```

The index allows PostgreSQL to consider an indexed access path when executing queries that filter on the `status` column.

### 3.3 Refreshing table statistics

PostgreSQL's `ANALYZE` command was used to refresh the table statistics available to the query planner.

```sql
ANALYZE public.orders_performance_test;
```

These statistics help PostgreSQL estimate the number of rows a query will return and choose an appropriate execution plan.

## 4. Results

The following table summarises the recorded before-and-after measurements.

| Measurement          | Before indexing | After indexing                         |
| -------------------- | --------------- | -------------------------------------- |
| Execution plan       | Sequential Scan | Bitmap Index Scan and Bitmap Heap Scan |
| Actual rows returned | 1,000           | 1,000                                  |
| Execution time       | 3.497 ms        | 2.358 ms                               |

The observed execution time decreased by approximately 32.6% between these two recorded runs.

This percentage describes the difference between the measured times in this experiment. It should not be interpreted as a guaranteed performance improvement for other workloads or future executions.

## 5. Interpretation of the Execution Plans

Before indexing, PostgreSQL used a sequential scan. It examined the table's records and filtered them to find those whose status was `Pending`.

After the index was created on the `status` column, PostgreSQL used a bitmap index scan to identify matching entries in the index, followed by a bitmap heap scan to retrieve the corresponding table rows.

The change in execution plan demonstrates that PostgreSQL can use an index when planning a query that filters on an indexed column. However, the presence of an index does not guarantee that an indexed plan will always be faster. The planner's choice depends on factors such as table size, data distribution, query selectivity, available statistics and the expected cost of retrieving the matching rows.

## 6. Statistics and Query Planning

The PostgreSQL `ANALYZE` command was executed on `public.orders_performance_test` to refresh the statistics used by the query planner.

After the index had been created, PostgreSQL estimated 1,000 matching rows, which agreed with the 1,000 rows actually returned. Following `ANALYZE`, the estimated and actual row counts remained 1,000.

The measured execution time after `ANALYZE` was 2.346 ms, compared with 2.358 ms in the preceding run. This small difference does not establish a meaningful performance improvement. It demonstrates why repeated measurements are preferable to drawing conclusions from individual runs.

The query continued to use a bitmap index scan followed by a bitmap heap scan after the statistics were refreshed.

## 7. Limitations

The recorded comparison is based on individual execution-time measurements rather than repeated trials. Cache effects, system activity, and other sources of timing variation may influence the results.

Although the recorded execution time was lower after indexing, repeated measurements under comparable conditions would provide stronger evidence of the index's performance impact.

The experiment also uses a simulated table and a specific filtering condition. Results may differ with larger or smaller tables, different status distributions, other query conditions, and different database workloads.

## 8. Conclusion

The experiment demonstrates how creating an index on the `status` column can change PostgreSQL's execution plan for a filtering query.

In the recorded comparison, PostgreSQL changed from a sequential scan to a bitmap index scan followed by a bitmap heap scan, while the number of rows returned remained 1,000. The measured execution time decreased from 3.497 ms to 2.358 ms in the recorded runs.

These findings illustrate the potential value of indexing, but the timing difference should be treated as preliminary because it is based on individual runs. Indexes also introduce storage and maintenance overhead. Their usefulness should therefore be evaluated against the workload, data distribution and query-planning costs.

PostgreSQL should be allowed to choose the execution plan it estimates to be most efficient based on the query, available indexes and current table statistics.

## 9. Evidence

The following screenshots are retained in the `evidence/` directory:

- `evidence/01_business_query_results.png` — results from the separate Fabbyent business query.
- `evidence/02_execution_plan_before_index.png` — execution plan before indexing, reported as showing a sequential scan.
- `evidence/03_execution_plan_after_index.png` — execution plan after indexing, reported as showing a bitmap index scan and bitmap heap scan.

The index definition was also checked against PostgreSQL's index catalogue, which confirmed that `idx_orders_performance_status` is a B-tree index on `public.orders_performance_test(status)`.
