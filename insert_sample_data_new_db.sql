-- Insert 5 records into each table for hotel_dbms_new database
USE hotel_dbms_new;

-- Insert 5 Admin records
INSERT INTO admin (username, password_hash, full_name, email) VALUES
('admin1', 'scrypt:32768:8:1$4pmacezsDPOn8Z6w$35b230a98020378ed148532b311dce43f11a42cd604f2dfdb1649421f43fcb098ae92f0174cdb4648186f1381b07659f65aed2e5fdc2df96ce2e9f32f360e764', 'Admin One', 'admin1@hotel.com'),
('admin2', 'scrypt:32768:8:1$4pmacezsDPOn8Z6w$35b230a98020378ed148532b311dce43f11a42cd604f2dfdb1649421f43fcb098ae92f0174cdb4648186f1381b07659f65aed2e5fdc2df96ce2e9f32f360e764', 'Admin Two', 'admin2@hotel.com'),
('admin3', 'scrypt:32768:8:1$4pmacezsDPOn8Z6w$35b230a98020378ed148532b311dce43f11a42cd604f2dfdb1649421f43fcb098ae92f0174cdb4648186f1381b07659f65aed2e5fdc2df96ce2e9f32f360e764', 'Admin Three', 'admin3@hotel.com'),
('admin4', 'scrypt:32768:8:1$4pmacezsDPOn8Z6w$35b230a98020378ed148532b311dce43f11a42cd604f2dfdb1649421f43fcb098ae92f0174cdb4648186f1381b07659f65aed2e5fdc2df96ce2e9f32f360e764', 'Admin Four', 'admin4@hotel.com'),
('admin5', 'scrypt:32768:8:1$4pmacezsDPOn8Z6w$35b230a98020378ed148532b311dce43f11a42cd604f2dfdb1649421f43fcb098ae92f0174cdb4648186f1381b07659f65aed2e5fdc2df96ce2e9f32f360e764', 'Admin Five', 'admin5@hotel.com');

-- Insert 5 User records
INSERT INTO user (username, password_hash, full_name, email) VALUES
('john_doe', 'scrypt:32768:8:1$5xlKdbehILZALMP5$c2eefe8e9667a6d927fc2eea9dd7302e4e682bc0adc31bf4f4169624eeae2bdb852969d8257e4732d2e3ea83fddb6a81d592f15c7d2b3360d8d2bb942f7c7354', 'John Doe', 'john@example.com'),
('jane_smith', 'scrypt:32768:8:1$5xlKdbehILZALMP5$c2eefe8e9667a6d927fc2eea9dd7302e4e682bc0adc31bf4f4169624eeae2bdb852969d8257e4732d2e3ea83fddb6a81d592f15c7d2b3360d8d2bb942f7c7354', 'Jane Smith', 'jane@example.com'),
('bob_wilson', 'scrypt:32768:8:1$5xlKdbehILZALMP5$c2eefe8e9667a6d927fc2eea9dd7302e4e682bc0adc31bf4f4169624eeae2bdb852969d8257e4732d2e3ea83fddb6a81d592f15c7d2b3360d8d2bb942f7c7354', 'Bob Wilson', 'bob@example.com'),
('alice_brown', 'scrypt:32768:8:1$5xlKdbehILZALMP5$c2eefe8e9667a6d927fc2eea9dd7302e4e682bc0adc31bf4f4169624eeae2bdb852969d8257e4732d2e3ea83fddb6a81d592f15c7d2b3360d8d2bb942f7c7354', 'Alice Brown', 'alice@example.com'),
('charlie_davis', 'scrypt:32768:8:1$5xlKdbehILZALMP5$c2eefe8e9667a6d927fc2eea9dd7302e4e682bc0adc31bf4f4169624eeae2bdb852969d8257e4732d2e3ea83fddb6a81d592f15c7d2b3360d8d2bb942f7c7354', 'Charlie Davis', 'charlie@example.com');

-- Insert 5 Facility records
INSERT INTO facility (name) VALUES
('WiFi'),
('Air Conditioning'),
('TV'),
('Mini Bar'),
('Room Service')
ON DUPLICATE KEY UPDATE name=name;

-- Insert 5 Room records
INSERT INTO room (room_number, room_type, price_per_night, capacity, status) VALUES
('101', 'Single', 50.00, 1, 'Available'),
('102', 'Single', 50.00, 1, 'Available'),
('201', 'Double', 80.00, 2, 'Available'),
('202', 'Double', 80.00, 2, 'Available'),
('301', 'Suite', 150.00, 4, 'Available');

-- Insert 5 Room-Facility relationships
INSERT INTO room_facility (room_id, facility_id) VALUES
(1, 1),  -- Room 101 has WiFi
(1, 2),  -- Room 101 has AC
(2, 1),  -- Room 102 has WiFi
(2, 3),  -- Room 102 has TV
(3, 1);  -- Room 201 has WiFi

-- Insert 5 Reservation records
INSERT INTO reservation (user_id, room_id, check_in, check_out, guests, status, total_cost, payment_status) VALUES
(1, 1, '2025-12-01', '2025-12-03', 1, 'Confirmed', 100.00, 'Paid'),
(2, 2, '2025-12-05', '2025-12-07', 1, 'Confirmed', 100.00, 'Pending'),
(3, 3, '2025-12-10', '2025-12-13', 2, 'Confirmed', 240.00, 'Paid'),
(4, 4, '2025-12-15', '2025-12-17', 2, 'Confirmed', 160.00, 'Pending'),
(5, 5, '2025-12-20', '2025-12-23', 3, 'Confirmed', 450.00, 'Paid');

