Index Performance Measurement Documentation
This file documents the performance impact of indexes created in database_index.sql for the ALX Airbnb Database Module's "Unleashing Advanced Querying Power" project. Performance is measured using EXPLAIN or ANALYZE before and after adding indexes to high-usage columns.
Index Overview

Indexes Created:
idx_user_email on User.email
idx_booking_user_id on Booking.user_id
idx_booking_property_id on Booking.property_id
idx_property_host_id on Property.host_id



Performance Measurements
Query 1: User-Specific Booking Lookup

SQL: SELECT * FROM Booking WHERE user_id = 'some-uuid';
Before Adding Index (idx_booking_user_id):
EXPLAIN Output: [Insert output here, e.g., "Seq Scan on Booking, cost=1000, rows=10000"]
Execution Time: [Insert time, e.g., "500ms"]
Rows Scanned: [Insert number, e.g., "10000"]


After Adding Index (idx_booking_user_id):
EXPLAIN Output: [Insert output here, e.g., "Index Scan using idx_booking_user_id, cost=10, rows=1"]
Execution Time: [Insert time, e.g., "5ms"]
Rows Scanned: [Insert number, e.g., "1"]



Query 2: Property Booking Count

SQL: SELECT p.property_id, COUNT(b.booking_id) FROM Property p LEFT JOIN Booking b ON p.property_id = b.property_id GROUP BY p.property_id;
Before Adding Index (idx_booking_property_id):
EXPLAIN Output: [Insert output here, e.g., "Hash Join, cost=2000, rows=5000"]
Execution Time: [Insert time, e.g., "800ms"]
Rows Scanned: [Insert number, e.g., "5000"]


After Adding Index (idx_booking_property_id):
EXPLAIN Output: [Insert output here, e.g., "Nested Loop, cost=50, rows=5000"]
Execution Time: [Insert time, e.g., "100ms"]
Rows Scanned: [Insert number, e.g., "5000"]



Measurement Instructions

Run the EXPLAIN command for each query before adding the indexes (as defined in database_index.sql).
Record the output, including cost, rows, and estimated execution time.
Apply the indexes by running the CREATE INDEX commands.
Run EXPLAIN again for the same queries and record the updated output.
Optionally, use ANALYZE for actual execution time with EXPLAIN ANALYZE (e.g., EXPLAIN ANALYZE SELECT * FROM Booking WHERE user_id = 'some-uuid';).
Update this file with the measured results.

Notes

Performance improvements depend on data volume and query patterns. Larger datasets typically show more significant gains.
Ensure the database is populated with representative data for accurate measurements.
Save this file after testing to document your findings.

Created on July 06, 2025
