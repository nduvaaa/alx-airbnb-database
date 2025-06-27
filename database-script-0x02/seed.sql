
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Insert Users (2 guests, 2 hosts, 1 admin)
INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
    (uuid_generate_v4(), 'John', 'Doe', 'john.doe@example.com', 'hash123', '+12345678901', 'guest', '2025-06-01 10:00:00'),
    (uuid_generate_v4(), 'Jane', 'Smith', 'jane.smith@example.com', 'hash456', '+12345678902', 'guest', '2025-06-01 11:00:00'),
    (uuid_generate_v4(), 'Alice', 'Johnson', 'alice.j@example.com', 'hash789', '+12345678903', 'host', '2025-06-01 12:00:00'),
    (uuid_generate_v4(), 'Bob', 'Williams', 'bob.w@example.com', 'hash012', '+12345678904', 'host', '2025-06-01 13:00:00'),
    (uuid_generate_v4(), 'Emma', 'Brown', 'emma.brown@example.com', 'hash345', '+12345678905', 'admin', '2025-06-01 14:00:00');

-- Insert Properties (owned by hosts: Alice and Bob)
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at) VALUES
    (uuid_generate_v4(), (SELECT user_id FROM "User" WHERE email = 'alice.j@example.com'), 'Cozy Cottage', 'A charming cottage in the countryside.', 'Nairobi, Kenya', 75.00, '2025-06-02 09:00:00', '2025-06-02 09:00:00'),
    (uuid_generate_v4(), (SELECT user_id FROM "User" WHERE email = 'alice.j@example.com'), 'City Loft', 'Modern loft in downtown Nairobi.', 'Nairobi, Kenya', 120.00, '2025-06-02 10:00:00', '2025-06-02 10:00:00'),
    (uuid_generate_v4(), (SELECT user_id FROM "User" WHERE email = 'bob.w@example.com'), 'Beach House', 'Spacious house by the coast.', 'Mombasa, Kenya', 150.00, '2025-06-02 11:00:00', '2025-06-02 11:00:00');

-- Insert Bookings (by guests John and Jane for properties)
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, status, created_at) VALUES
    (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'Cozy Cottage'), (SELECT user_id FROM "User" WHERE email = 'john.doe@example.com'), '2025-07-01', '2025-07-05', 'confirmed', '2025-06-15 08:00:00'),
    (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'City Loft'), (SELECT user_id FROM "User" WHERE email = 'john.doe@example.com'), '2025-07-10', '2025-07-12', 'pending', '2025-06-16 09:00:00'),
    (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'Beach House'), (SELECT user_id FROM "User" WHERE email = 'jane.smith@example.com'), '2025-07-15', '2025-07-20', 'confirmed', '2025-06-17 10:00:00'),
    (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'Cozy Cottage'), (SELECT user_id FROM "User" WHERE email = 'jane.smith@example.com'), '2025-08-01', '2025-08-03', 'canceled', '2025-06-18 11:00:00');

-- Insert Payments (for confirmed bookings)
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
    (uuid_generate_v4(), (SELECT booking_id FROM Booking WHERE user_id = (SELECT user_id FROM "User" WHERE email = 'john.doe@example.com') AND property_id = (SELECT property_id FROM Property WHERE name = 'Cozy Cottage')), 300.00, '2025-06-15 09:00:00', 'credit_card'),
    (uuid_generate_v4(), (SELECT booking/storage/Booking WHERE user_id = (SELECT user_id FROM "User" WHERE email = 'jane.smith@example.com') AND property_id = (SELECT property_id FROM Property WHERE name = 'Beach House')), 750.00, '2025-06-17 11:00:00', 'paypal');

-- Insert Reviews (by guests for properties they booked)
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
    (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'Cozy Cottage'), (SELECT user_id FROM "User" WHERE email = 'john.doe@example.com'), 4, 'Lovely stay, very peaceful!', '2025-07-06 10:00:00'),
    (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'Beach House'), (SELECT user_id FROM "User" WHERE email = 'jane.smith@example.com'), 5, 'Amazing views and great host!', '2025-07-21 12:00:00');

-- Insert Messages (between users, e.g., guest to host)
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
    (uuid_generate_v4(), (SELECT user_id FROM "User" WHERE email = 'john.doe@example.com'), (SELECT user_id FROM "User" WHERE email = 'alice.j@example.com'), 'Is the Cozy Cottage available for July 1-5?', '2025-06-10 14:00:00'),
    (uuid_generate_v4(), (SELECT user_id FROM "User" WHERE email = 'alice.j@example.com'), (SELECT user_id FROM "User" WHERE email = 'john.doe@example.com'), 'Yes, it’s available! Looking forward to hosting you.', '2025-06-10 15:00:00'),
    (uuid_generate_v4(), (SELECT user_id FROM "User" WHERE email = 'jane.smith@example.com'), (SELECT user_id FROM "User" WHERE email = 'bob.w@example.com'), 'Can you confirm parking at the Beach House?', '2025-06-15 16:00:00');