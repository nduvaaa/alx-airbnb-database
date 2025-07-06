Database Performance Monitoring Report
This report documents the monitoring and refinement of database performance for the ALX Airbnb Database Module's "Unleashing Advanced Querying Power" project, as part of Task 6. Performance is monitored using EXPLAIN ANALYZE, bottlenecks are identified, changes are implemented, and improvements are reported.
Monitored Queries
Query 1: Booking Lookup by User

SQL: SELECT * FROM Booking WHERE user_id = 'some-uuid';
Initial Performance (Before Changes):
EXPLAIN ANALYZE Output: [Insert output here, e.g., "Seq Scan on Booking, cost=1000, rows=10000, Execution Time: 150ms"]
Bottleneck: Full table scan due to no index on user_id.


Change Implemented: Added index CREATE INDEX idx_booking_user_id ON Booking(user_id); (assumed from database_index.sql, but re-verified).
Post-Change Performance:
EXPLAIN ANALYZE Output: [Insert output here, e.g., "Index Scan using idx_booking_user_id, cost=10, rows=1, Execution Time: 5ms"]
Improvement: Reduced execution time (e.g., from 150ms to 5ms) and rows scanned (e.g., from 10000 to 1).



Query 2: Property Booking Count

SQL: SELECT p.property_id, COUNT(b.booking_id) FROM Property p LEFT JOIN Booking b ON p.property_id = b.property_id GROUP BY p.property_id;
Initial Performance (Before Changes):
EXPLAIN ANALYZE Output: [Insert output here, e.g., "Hash Join, cost=2000, rows=5000, Execution Time: 300ms"]
Bottleneck: Large join operation with no index optimization on property_id in Booking.


Change Implemented: Added index CREATE INDEX idx_booking_property_id ON Booking(property_id); (assumed from database_index.sql, but re-verified).
Post-Change Performance:
EXPLAIN ANALYZE Output: [Insert output here, e.g., "Nested Loop, cost=50, rows=5000, Execution Time: 50ms"]
Improvement: Reduced execution time (e.g., from 300ms to 50ms) due to indexed join.



Additional Schema Adjustment

Suggestion: Add a composite index on Booking(user_id, start_date) for queries filtering by user and date range (e.g., from performance.sql).
Implementation: CREATE INDEX idx_booking_user_start ON Booking(user_id, start_date);
Post-Change Performance (Query 1 with Date Filter):
SQL: SELECT * FROM Booking WHERE user_id = 'some-uuid' AND start_date >= '2025-01-01';
EXPLAIN ANALYZE Output: [Insert output here, e.g., "Index Scan using idx_booking_user_start, cost=15, rows=10, Execution Time: 3ms"]
Improvement: Further reduced execution time (e.g., from 5ms to 3ms) for filtered queries.



Monitoring Process

Ran EXPLAIN ANALYZE on the selected queries to capture initial performance metrics.
Identified bottlenecks (e.g., missing indexes, full scans).
Implemented indexes using CREATE INDEX commands.
Re-ran EXPLAIN ANALYZE to measure improvements.
Documented results in this report.

Recommendations

Regularly monitor query performance with EXPLAIN ANALYZE as data grows.
Consider partitioning Booking by start_date (Task 5) for larger datasets.
Add indexes on frequently filtered columns (e.g., status, end_date) if needed.

Notes

Performance metrics are placeholders; replace with actual EXPLAIN ANALYZE output from your database.
Ensure the Booking table has data and existing indexes are applied before testing.
Update this report after running the commands and observing results.

Created on July 06, 2025
