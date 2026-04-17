-- =====================================================
-- COMPLETE SQL REFERENCE FOR HOTEL DBMS
-- =====================================================
-- Database: hotel_dbms_new
-- This file contains: UPDATE, ALTER, JOINs, DELETE, VIEWs
-- =====================================================

USE hotel_dbms_new;

-- =====================================================
-- 1. UPDATE QUERIES
-- =====================================================

-- Update user email
UPDATE user 
SET email = 'newemail@example.com' 
WHERE username = 'alice';

-- Update room price
UPDATE room 
SET price_per_night = 75.00 
WHERE room_number = '101';

-- Update room status
UPDATE room 
SET status = 'Booked' 
WHERE room_number = '201';

-- Update multiple columns
UPDATE room 
SET price_per_night = 90.00, 
    capacity = 3, 
    status = 'Available' 
WHERE room_number = '202';

-- Update reservation status
UPDATE reservation 
SET status = 'Cancelled', 
    payment_status = 'Refunded' 
WHERE id = 1;

-- Update admin details
UPDATE admin 
SET full_name = 'Updated Admin Name', 
    email = 'newadmin@hotel.com' 
WHERE username = 'admin';

-- Update with condition
UPDATE reservation 
SET payment_status = 'Paid' 
WHERE payment_status = 'Pending' 
  AND total_cost < 200.00;

-- Update using subquery
UPDATE room 
SET status = 'Maintenance' 
WHERE id IN (
    SELECT room_id 
    FROM reservation 
    WHERE status = 'Cancelled' 
    GROUP BY room_id 
    HAVING COUNT(*) > 2
);

-- =====================================================
-- 2. ALTER TABLE QUERIES
-- =====================================================

-- Add a new column
ALTER TABLE user 
ADD COLUMN phone_number VARCHAR(20);

-- Add column with default value
ALTER TABLE room 
ADD COLUMN floor_number INT DEFAULT 1;

-- Add column with NOT NULL constraint
ALTER TABLE reservation 
ADD COLUMN special_requests TEXT;

-- Modify column data type
ALTER TABLE room 
MODIFY COLUMN price_per_night DECIMAL(10, 2);

-- Change column name
ALTER TABLE user 
CHANGE COLUMN phone_number contact_phone VARCHAR(20);

-- Add index to improve query performance
ALTER TABLE reservation 
ADD INDEX idx_check_in (check_in);

ALTER TABLE room 
ADD INDEX idx_room_type_status (room_type, status);

-- Add unique constraint
ALTER TABLE user 
ADD UNIQUE KEY unique_phone (contact_phone);

-- Add foreign key constraint (if not already exists)
ALTER TABLE reservation 
ADD CONSTRAINT fk_reservation_user 
FOREIGN KEY (user_id) REFERENCES user(id) 
ON DELETE CASCADE;

-- Drop a column
-- ALTER TABLE user DROP COLUMN contact_phone;

-- Rename table
-- ALTER TABLE user RENAME TO customer;

-- =====================================================
-- 3. ALL TYPES OF JOINS
-- =====================================================

-- INNER JOIN - Get reservations with user and room details
SELECT 
    res.id AS reservation_id,
    u.username,
    u.full_name,
    r.room_number,
    r.room_type,
    res.check_in,
    res.check_out,
    res.total_cost
FROM reservation res
INNER JOIN user u ON res.user_id = u.id
INNER JOIN room r ON res.room_id = r.id;

-- LEFT JOIN - Get all users with their reservations (even if no reservations)
SELECT 
    u.id AS user_id,
    u.username,
    u.full_name,
    res.id AS reservation_id,
    res.check_in,
    res.check_out,
    res.status
FROM user u
LEFT JOIN reservation res ON u.id = res.user_id
ORDER BY u.username;

-- RIGHT JOIN - Get all rooms with reservations (even if no reservations)
SELECT 
    r.room_number,
    r.room_type,
    r.status AS room_status,
    res.id AS reservation_id,
    res.check_in,
    res.check_out
FROM reservation res
RIGHT JOIN room r ON res.room_id = r.id
ORDER BY r.room_number;

-- FULL OUTER JOIN (MySQL doesn't support FULL OUTER JOIN, use UNION)
-- Get all users and all rooms with their relationships
SELECT 
    u.id AS user_id,
    u.username,
    NULL AS room_number,
    NULL AS reservation_id
FROM user u
LEFT JOIN reservation res ON u.id = res.user_id
WHERE res.id IS NULL

UNION

SELECT 
    NULL AS user_id,
    NULL AS username,
    r.room_number,
    res.id AS reservation_id
FROM room r
LEFT JOIN reservation res ON r.id = res.room_id
WHERE res.id IS NULL;

-- SELF JOIN - Find users who have multiple reservations
SELECT 
    u1.username AS user1,
    u2.username AS user2,
    COUNT(*) AS common_reservations
FROM reservation r1
JOIN reservation r2 ON r1.user_id = r2.user_id AND r1.id != r2.id
JOIN user u1 ON r1.user_id = u1.id
JOIN user u2 ON r2.user_id = u2.id
GROUP BY u1.username, u2.username;

-- MULTIPLE JOINS - Rooms with facilities and reservations
SELECT 
    r.room_number,
    r.room_type,
    GROUP_CONCAT(DISTINCT f.name ORDER BY f.name SEPARATOR ', ') AS facilities,
    COUNT(DISTINCT res.id) AS total_reservations
FROM room r
LEFT JOIN room_facility rf ON r.id = rf.room_id
LEFT JOIN facility f ON rf.facility_id = f.id
LEFT JOIN reservation res ON r.id = res.room_id
GROUP BY r.id, r.room_number, r.room_type;

-- CROSS JOIN - All possible user-room combinations (Cartesian product)
SELECT 
    u.username,
    r.room_number,
    r.room_type
FROM user u
CROSS JOIN room r
LIMIT 20;  -- Limit to avoid too many results

-- JOIN with WHERE clause
SELECT 
    u.username,
    r.room_number,
    res.check_in,
    res.check_out
FROM reservation res
JOIN user u ON res.user_id = u.id
JOIN room r ON res.room_id = r.id
WHERE res.status = 'Confirmed'
  AND res.check_in >= '2025-12-01';

-- JOIN with aggregate functions
SELECT 
    u.username,
    COUNT(res.id) AS total_bookings,
    SUM(res.total_cost) AS total_spent,
    AVG(res.total_cost) AS avg_booking_cost
FROM user u
LEFT JOIN reservation res ON u.id = res.user_id
GROUP BY u.id, u.username;

-- =====================================================
-- 4. DELETE QUERIES
-- =====================================================

-- Delete a specific reservation
DELETE FROM reservation 
WHERE id = 5;

-- Delete reservations with specific status
DELETE FROM reservation 
WHERE status = 'Cancelled';

-- Delete old reservations (before a date)
DELETE FROM reservation 
WHERE check_out < '2025-01-01';

-- Delete user (be careful with foreign keys)
-- DELETE FROM user WHERE id = 1;

-- Delete room (if no reservations exist)
DELETE FROM room 
WHERE id NOT IN (SELECT DISTINCT room_id FROM reservation);

-- Delete facility that's not used
DELETE FROM facility 
WHERE id NOT IN (SELECT DISTINCT facility_id FROM room_facility);

-- Delete room-facility relationships
DELETE FROM room_facility 
WHERE room_id = 1 AND facility_id = 2;

-- Delete with subquery
DELETE FROM reservation 
WHERE user_id IN (
    SELECT id FROM user 
    WHERE email LIKE '%@olddomain.com'
);

-- Delete all data from a table (TRUNCATE is faster)
-- TRUNCATE TABLE reservation;

-- Delete with LIMIT (MySQL specific)
DELETE FROM reservation 
WHERE status = 'Cancelled' 
ORDER BY created_at ASC 
LIMIT 10;

-- =====================================================
-- 5. VIEW CREATION QUERIES
-- =====================================================

-- View 1: Reservation Summary View
CREATE OR REPLACE VIEW v_reservation_summary AS
SELECT 
    res.id AS reservation_id,
    u.username,
    u.full_name AS user_name,
    u.email AS user_email,
    r.room_number,
    r.room_type,
    r.price_per_night,
    res.check_in,
    res.check_out,
    DATEDIFF(res.check_out, res.check_in) AS nights,
    res.guests,
    res.status,
    res.total_cost,
    res.payment_status,
    res.created_at
FROM reservation res
JOIN user u ON res.user_id = u.id
JOIN room r ON res.room_id = r.id;

-- View 2: Room Details with Facilities
CREATE OR REPLACE VIEW v_room_details AS
SELECT 
    r.id AS room_id,
    r.room_number,
    r.room_type,
    r.price_per_night,
    r.capacity,
    r.status,
    GROUP_CONCAT(DISTINCT f.name ORDER BY f.name SEPARATOR ', ') AS facilities,
    COUNT(DISTINCT rf.facility_id) AS facility_count
FROM room r
LEFT JOIN room_facility rf ON r.id = rf.room_id
LEFT JOIN facility f ON rf.facility_id = f.id
GROUP BY r.id, r.room_number, r.room_type, r.price_per_night, r.capacity, r.status;

-- View 3: Available Rooms View
CREATE OR REPLACE VIEW v_available_rooms AS
SELECT 
    r.id,
    r.room_number,
    r.room_type,
    r.price_per_night,
    r.capacity,
    r.status
FROM room r
WHERE r.status = 'Available'
  AND r.id NOT IN (
      SELECT DISTINCT room_id 
      FROM reservation 
      WHERE status = 'Confirmed' 
        AND check_in <= CURDATE() 
        AND check_out >= CURDATE()
  );

-- View 4: User Booking History
CREATE OR REPLACE VIEW v_user_bookings AS
SELECT 
    u.id AS user_id,
    u.username,
    u.full_name,
    COUNT(res.id) AS total_bookings,
    SUM(CASE WHEN res.status = 'Confirmed' THEN 1 ELSE 0 END) AS confirmed_bookings,
    SUM(CASE WHEN res.status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_bookings,
    SUM(res.total_cost) AS total_spent,
    MAX(res.check_out) AS last_booking_date
FROM user u
LEFT JOIN reservation res ON u.id = res.user_id
GROUP BY u.id, u.username, u.full_name;

-- View 5: Revenue Summary
CREATE OR REPLACE VIEW v_revenue_summary AS
SELECT 
    DATE(res.check_in) AS booking_date,
    COUNT(res.id) AS total_bookings,
    SUM(res.total_cost) AS total_revenue,
    SUM(CASE WHEN res.payment_status = 'Paid' THEN res.total_cost ELSE 0 END) AS paid_revenue,
    SUM(CASE WHEN res.payment_status = 'Pending' THEN res.total_cost ELSE 0 END) AS pending_revenue,
    AVG(res.total_cost) AS avg_booking_value
FROM reservation res
WHERE res.status = 'Confirmed'
GROUP BY DATE(res.check_in)
ORDER BY booking_date DESC;

-- View 6: Room Occupancy Rate
CREATE OR REPLACE VIEW v_room_occupancy AS
SELECT 
    r.room_number,
    r.room_type,
    COUNT(res.id) AS total_reservations,
    SUM(DATEDIFF(res.check_out, res.check_in)) AS total_nights_booked,
    AVG(res.total_cost) AS avg_revenue_per_booking
FROM room r
LEFT JOIN reservation res ON r.id = res.room_id AND res.status = 'Confirmed'
GROUP BY r.id, r.room_number, r.room_type;

-- View 7: Facility Usage Statistics
CREATE OR REPLACE VIEW v_facility_usage AS
SELECT 
    f.id AS facility_id,
    f.name AS facility_name,
    COUNT(DISTINCT rf.room_id) AS rooms_with_facility,
    COUNT(DISTINCT res.id) AS reservations_in_rooms_with_facility
FROM facility f
LEFT JOIN room_facility rf ON f.id = rf.facility_id
LEFT JOIN room r ON rf.room_id = r.id
LEFT JOIN reservation res ON r.id = res.room_id AND res.status = 'Confirmed'
GROUP BY f.id, f.name
ORDER BY rooms_with_facility DESC;

-- View 8: Admin Dashboard Summary
CREATE OR REPLACE VIEW v_admin_dashboard AS
SELECT 
    (SELECT COUNT(*) FROM user) AS total_users,
    (SELECT COUNT(*) FROM admin) AS total_admins,
    (SELECT COUNT(*) FROM room) AS total_rooms,
    (SELECT COUNT(*) FROM room WHERE status = 'Available') AS available_rooms,
    (SELECT COUNT(*) FROM room WHERE status = 'Booked') AS booked_rooms,
    (SELECT COUNT(*) FROM reservation) AS total_reservations,
    (SELECT COUNT(*) FROM reservation WHERE status = 'Confirmed') AS confirmed_reservations,
    (SELECT COUNT(*) FROM reservation WHERE status = 'Cancelled') AS cancelled_reservations,
    (SELECT SUM(total_cost) FROM reservation WHERE payment_status = 'Paid') AS total_revenue,
    (SELECT SUM(total_cost) FROM reservation WHERE payment_status = 'Pending') AS pending_payments;

-- View 9: Upcoming Reservations
CREATE OR REPLACE VIEW v_upcoming_reservations AS
SELECT 
    res.id AS reservation_id,
    u.username,
    u.full_name,
    r.room_number,
    r.room_type,
    res.check_in,
    res.check_out,
    res.guests,
    res.total_cost,
    res.payment_status,
    DATEDIFF(res.check_in, CURDATE()) AS days_until_checkin
FROM reservation res
JOIN user u ON res.user_id = u.id
JOIN room r ON res.room_id = r.id
WHERE res.status = 'Confirmed'
  AND res.check_in >= CURDATE()
ORDER BY res.check_in ASC;

-- View 10: Customer Lifetime Value
CREATE OR REPLACE VIEW v_customer_lifetime_value AS
SELECT 
    u.id AS user_id,
    u.username,
    u.full_name,
    u.email,
    COUNT(res.id) AS total_bookings,
    SUM(res.total_cost) AS lifetime_value,
    AVG(res.total_cost) AS avg_booking_value,
    MIN(res.check_in) AS first_booking_date,
    MAX(res.check_in) AS last_booking_date,
    DATEDIFF(MAX(res.check_in), MIN(res.check_in)) AS customer_duration_days
FROM user u
LEFT JOIN reservation res ON u.id = res.user_id AND res.status = 'Confirmed'
GROUP BY u.id, u.username, u.full_name, u.email
ORDER BY lifetime_value DESC;

-- =====================================================
-- VIEW USAGE EXAMPLES
-- =====================================================

-- Query a view
-- SELECT * FROM v_reservation_summary;
-- SELECT * FROM v_available_rooms;
-- SELECT * FROM v_user_bookings WHERE username = 'alice';

-- Drop a view
-- DROP VIEW IF EXISTS v_reservation_summary;

-- Show all views
-- SHOW FULL TABLES WHERE Table_type = 'VIEW';

-- =====================================================
-- END OF SQL REFERENCE
-- =====================================================

