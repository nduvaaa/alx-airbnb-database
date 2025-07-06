-- Query 1: Booking Lookup by User (Initial Performance)
EXPLAIN ANALYZE SELECT *
FROM Booking
WHERE user_id = 'some-uuid';

-- Query 2: Property Booking Count (Initial Performance)
EXPLAIN ANALYZE SELECT p.property_id, COUNT(b.booking_id)
FROM Property p
LEFT JOIN Booking b ON p.property_id = b.property_id
GROUP BY p.property_id;

-- Implement Changes: Add or verify existing indexes
-- Verify or create index on Booking.user_id (assumed from database_index.sql)
CREATE INDEX IF NOT EXISTS idx_booking_user_id ON Booking(user_id);

-- Verify or create index on Booking.property_id (assumed from database_index.sql)
CREATE INDEX IF NOT EXISTS idx_booking_property_id ON Booking(property_id);

-- Add new composite index on Booking(user_id, start_date)
CREATE INDEX idx_booking_user_start ON Booking(user_id, start_date);

-- Query 1: Booking Lookup by User with Date Filter (Post-Change Performance)
EXPLAIN ANALYZE SELECT *
FROM Booking
WHERE user_id = 'some-uuid'
AND start_date >= '2025-01-01';

-- Query 2: Property Booking Count (Post-Change Performance)
EXPLAIN ANALYZE SELECT p.property_id, COUNT(b.booking_id)
FROM Property p
LEFT JOIN Booking b ON p.property_id = b.property_id
GROUP BY p.property_id;
