Query Optimization Report
This report documents the optimization process for a complex query in the ALX Airbnb Database Module's "Unleashing Advanced Querying Power" project, as part of Task 4.
Initial Query

SQL: Retrieves all bookings with user, property, and payment details.
Performance Analysis:
Ran EXPLAIN ANALYZE on the initial query.
Expected Output: [Insert actual EXPLAIN ANALYZE output here, e.g., "Hash Join, cost=5000, rows=10000, Execution Time: 200ms"]
Identified Inefficiencies:
Full table scans on large tables (Booking, User, Property, Payment) due to multiple INNER JOINs.
Selection of all columns, including unused ones (e.g., u.phone_number, p.description), increasing data transfer.
No WHERE clause to filter rows, processing all records.





Refactored Query

SQL: Optimized version with selective columns and a filter.
Optimizations Applied:
Column Selection: Reduced to essential fields (booking_id, start_date, etc.) to minimize data transfer.
Filtering: Added WHERE b.status = 'confirmed' to limit rows to confirmed bookings, reducing the dataset.
Indexing: Leverages existing indexes (idx_booking_user_id, idx_booking_property_id) from database_index.sql for JOIN efficiency.
Ordering: Added ORDER BY b.start_date with potential indexing (e.g., CREATE INDEX idx_booking_start_date ON Booking(start_date); if needed).


Performance Analysis:
Ran EXPLAIN ANALYZE on the refactored query.
Expected Output: [Insert actual EXPLAIN ANALYZE output here, e.g., "Index Scan, cost=50, rows=1000, Execution Time: 20ms"]
Observed Improvements: Reduced execution time (e.g., from 200ms to 20ms), fewer rows scanned, and lower cost due to filtering and indexing.



Recommendations

Add an index on Booking.start_date if sorting by date is frequent: CREATE INDEX idx_booking_start_date ON Booking(start_date);.
Consider partitioning Booking by start_date (Task 7) for large datasets.
Regularly analyze query performance with EXPLAIN ANALYZE and adjust indexes as needed.

Notes

Performance metrics are placeholders; replace with actual EXPLAIN ANALYZE output from your database.
Ensure the Payment table exists in your schema with columns payment_id, amount, and payment_date.
Update this report after testing the refactored query.

Created on July 06, 2025
