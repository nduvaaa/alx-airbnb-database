-- Create indexes for high-usage columns

-- Index on User table: email (used for unique lookups, e.g., login queries)
CREATE INDEX idx_user_email ON User(email);

-- Index on Booking table: user_id (used in JOINs and WHERE clauses for user-specific bookings)
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- Index on Booking table: property_id (used in JOINs and WHERE clauses for property-specific bookings)
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- Index on Property table: host_id (used in JOINs to filter by host)
CREATE INDEX idx_property_host_id ON Property(host_id);

-- Performance measurement examples (run these before and after adding indexes)

-- Before adding indexes: EXPLAIN ANALYZE for a user-specific booking query
EXPLAIN ANALYZE SELECT *
FROM Booking b
WHERE b.user_id = 'some-uuid';

-- After adding idx_booking_user_id: EXPLAIN ANALYZE for the same query
EXPLAIN ANALYZE SELECT *
FROM Booking b
WHERE b.user_id = 'some-uuid';

-- Before adding indexes: EXPLAIN ANALYZE for a property booking count
EXPLAIN ANALYZE SELECT p.property_id, COUNT(b.booking_id)
FROM Property p
LEFT JOIN Booking b ON p.property_id = b.property_id
GROUP BY p.property_id;

-- After adding idx_booking_property_id: EXPLAIN ANALYZE for the same query
EXPLAIN ANALYZE SELECT p.property_id, COUNT(b.booking_id)
FROM Property p
LEFT JOIN Booking b ON p.property_id = b.property_id
GROUP BY p.property_id;
