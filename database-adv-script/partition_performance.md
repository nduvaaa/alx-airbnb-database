Partitioning Performance Report
This report documents the implementation and performance impact of partitioning the Booking table in the ALX Airbnb Database Module's "Unleashing Advanced Querying Power" project, as part of Task 5.
Partitioning Strategy

Table: Booking
Partition Key: start_date (DATE)
Method: Range partitioning by year.
Partitions Created:
Booking_2024: Covers dates from January 1, 2024, to January 1, 2025.
Booking_2025: Covers dates from January 1, 2025, to January 1, 2026.


Implementation: Used CREATE TABLE ... PARTITION OF to define the partition structure, with sample data inserted for testing.

Performance Testing

Query: SELECT * FROM Booking WHERE start_date BETWEEN '2025-06-01' AND '2025-06-30';
Before Partitioning:
EXPLAIN ANALYZE Output: [Insert output here, e.g., "Seq Scan on Booking, cost=1000, rows=10000, Execution Time: 150ms"]
Rows Scanned: [Insert number, e.g., "10000"]
Execution Time: [Insert time, e.g., "150ms"]


After Partitioning:
EXPLAIN ANALYZE Output: [Insert output here, e.g., "Partitioned Scan on Booking_2025, cost=50, rows=1000, Execution Time: 20ms"]
Rows Scanned: [Insert number, e.g., "1000"]
Execution Time: [Insert time, e.g., "20ms"]



Observed Improvements

Reduction in Rows Scanned: Partitioning limited the scan to the Booking_2025 partition, reducing the dataset from the full table to the relevant date range.
Execution Time: Decreased significantly (e.g., from 150ms to 20ms) due to targeted data access.
Cost Efficiency: Lower cost in the EXPLAIN plan due to partition pruning, avoiding unnecessary scans.

Recommendations

Add more partitions for future years (e.g., Booking_2026) as data grows.
Consider indexing start_date (e.g., CREATE INDEX idx_booking_start_date ON Booking(start_date);) for further optimization.
Regularly monitor partition performance with EXPLAIN ANALYZE as the dataset scales.

Notes

Performance metrics are placeholders; replace with actual EXPLAIN ANALYZE output from your database after partitioning.
Ensure the Booking table is repopulated with your data after partitioning.
Update this report after testing the partitioned table.

Created on July 06, 2025
