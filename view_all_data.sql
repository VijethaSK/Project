-- SQL Commands to View All Data in Hotel DBMS Database
-- Run these in MySQL command line or phpMyAdmin

USE hotel_dbms;

-- View all users
SELECT * FROM user;

-- View all admins
SELECT * FROM admin;

-- View all rooms
SELECT * FROM room;

-- View all facilities
SELECT * FROM facility;

-- View room-facility relationships
SELECT 
    r.room_number,
    r.room_type,
    f.name AS facility
FROM room r
JOIN room_facility rf ON r.id = rf.room_id
JOIN facility f ON rf.facility_id = f.id
ORDER BY r.room_number, f.name;

-- View all reservations
SELECT * FROM reservation;

-- View reservations with details (room and user info)
SELECT 
    res.id AS reservation_id,
    u.username,
    u.full_name,
    r.room_number,
    r.room_type,
    res.check_in,
    res.check_out,
    res.guests,
    res.status,
    res.total_cost,
    res.payment_status,
    res.created_at
FROM reservation res
JOIN user u ON res.user_id = u.id
JOIN room r ON res.room_id = r.id
ORDER BY res.created_at DESC;

-- Count records in each table
SELECT 'user' AS table_name, COUNT(*) AS count FROM user
UNION ALL
SELECT 'admin', COUNT(*) FROM admin
UNION ALL
SELECT 'room', COUNT(*) FROM room
UNION ALL
SELECT 'facility', COUNT(*) FROM facility
UNION ALL
SELECT 'room_facility', COUNT(*) FROM room_facility
UNION ALL
SELECT 'reservation', COUNT(*) FROM reservation;

-- View available rooms
SELECT * FROM room WHERE status = 'Available';

-- View booked rooms
SELECT * FROM room WHERE status = 'Booked';

-- View rooms with their facilities (detailed view)
SELECT 
    r.id,
    r.room_number,
    r.room_type,
    r.price_per_night,
    r.capacity,
    r.status,
    GROUP_CONCAT(f.name SEPARATOR ', ') AS facilities
FROM room r
LEFT JOIN room_facility rf ON r.id = rf.room_id
LEFT JOIN facility f ON rf.facility_id = f.id
GROUP BY r.id, r.room_number, r.room_type, r.price_per_night, r.capacity, r.status
ORDER BY r.room_number;

