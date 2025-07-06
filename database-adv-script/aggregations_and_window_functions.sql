-- Query 1: Total number of bookings made by each user using COUNT and GROUP BY
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(b.booking_id) AS total_bookings
FROM 
    User u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id
GROUP BY 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
ORDER BY 
    total_bookings DESC;

-- Query 2: Rank properties based on total number of bookings using RANK window function
WITH PropertyBookings AS (
    SELECT 
        p.property_id,
        p.name,
        p.location,
        COUNT(b.booking_id) AS total_bookings
    FROM 
        Property p
    LEFT JOIN 
        Booking b ON p.property_id = b.property_id
    GROUP BY 
        p.property_id,
        p.name,
        p.location
)
SELECT 
    property_id,
    name,
    location,
    total_bookings,
    RANK() OVER (ORDER BY total_bookings DESC) AS booking_rank
FROM 
    PropertyBookings
ORDER BY 
    booking_rank;

-- Query 3: Average rating per property using AVG and GROUP BY
SELECT 
    p.property_id,
    p.name,
    p.location,
    COALESCE(AVG(r.rating), 0) AS average_rating,
    COUNT(r.review_id) AS review_count
FROM 
    Property p
LEFT JOIN 
    Review r ON p.property_id = r.property_id
GROUP BY 
    p.property_id,
    p.name,
    p.location
ORDER BY 
    average_rating DESC;

-- Query 4: Rank properties based on total number of bookings using ROW_NUMBER window function
WITH PropertyBookings AS (
    SELECT 
        p.property_id,
        p.name,
        p.location,
        COUNT(b.booking_id) AS total_bookings
    FROM 
        Property p
    LEFT JOIN 
        Booking b ON p.property_id = b.property_id
    GROUP BY 
        p.property_id,
        p.name,
        p.location
)
SELECT 
    property_id,
    name,
    location,
    total_bookings,
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS booking_row_number
FROM 
    PropertyBookings
ORDER BY 
    booking_row_number;
