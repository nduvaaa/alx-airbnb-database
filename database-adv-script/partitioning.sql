-- Drop existing Booking table if it exists (for testing purposes, adjust as needed)
DROP TABLE IF EXISTS Booking CASCADE;

-- Create parent table for partitioning
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY,
    user_id UUID,
    property_id UUID,
    start_date DATE,
    end_date DATE,
    total_price DECIMAL,
    status VARCHAR(50),
    created_at TIMESTAMP
) PARTITION BY RANGE (start_date);

-- Create partitions for different date ranges (e.g., yearly partitions for 2024 and 2025)
CREATE TABLE Booking_2024 PARTITION OF Booking
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE Booking_2025 PARTITION OF Booking
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Insert sample data (for testing, replace with your data loading process)
INSERT INTO Booking (booking_id, user_id, property_id, start_date, end_date, total_price, status, created_at)
SELECT
    gen_random_uuid(),
    (SELECT user_id FROM User ORDER BY random() LIMIT 1),
    (SELECT property_id FROM Property ORDER BY random() LIMIT 1),
    start_date,
    start_date + INTERVAL '7 days',
    ROUND((RANDOM() * 1000 + 100)::numeric, 2),
    CASE WHEN RANDOM() > 0.3 THEN 'confirmed' ELSE 'pending' END,
    CURRENT_TIMESTAMP
FROM generate_series('2024-01-01'::date, '2025-12-31'::date, '1 day') AS start_date;

-- Performance test query: Fetch bookings for a specific date range
EXPLAIN ANALYZE SELECT *
FROM Booking
WHERE start_date BETWEEN '2025-06-01' AND '2025-06-30';
