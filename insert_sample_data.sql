-- Insert 5 records into each table for hotel_dbms_new

USE hotel_dbms_new;

-- Insert 5 Admins
INSERT INTO admin (username, password_hash, full_name, email) VALUES
('admin1', 'scrypt:32768:8:1$oi8ShEG6gYjzA6tH$b1430407a1586f0ec2cd91673178de4c1ecfba13ad485e347df877e629cbfd9afbdf789dbb7a98a3830f97039d7af42cae163d2cb2767606c0cb4192e8036fe3', 'John Manager', 'admin1@hotel.com'),
('admin2', 'scrypt:32768:8:1$oi8ShEG6gYjzA6tH$b1430407a1586f0ec2cd91673178de4c1ecfba13ad485e347df877e629cbfd9afbdf789dbb7a98a3830f97039d7af42cae163d2cb2767606c0cb4192e8036fe3', 'Sarah Supervisor', 'admin2@hotel.com'),
('admin3', 'scrypt:32768:8:1$oi8ShEG6gYjzA6tH$b1430407a1586f0ec2cd91673178de4c1ecfba13ad485e347df877e629cbfd9afbdf789dbb7a98a3830f97039d7af42cae163d2cb2767606c0cb4192e8036fe3', 'Mike Director', 'admin3@hotel.com'),
('admin4', 'scrypt:32768:8:1$oi8ShEG6gYjzA6tH$b1430407a1586f0ec2cd91673178de4c1ecfba13ad485e347df877e629cbfd9afbdf789dbb7a98a3830f97039d7af42cae163d2cb2767606c0cb4192e8036fe3', 'Emily Coordinator', 'admin4@hotel.com'),
('admin5', 'scrypt:32768:8:1$oi8ShEG6gYjzA6tH$b1430407a1586f0ec2cd91673178de4c1ecfba13ad485e347df877e629cbfd9afbdf789dbb7a98a3830f97039d7af42cae163d2cb2767606c0cb4192e8036fe3', 'David Administrator', 'admin5@hotel.com');

-- Insert 5 Users
INSERT INTO user (username, password_hash, full_name, email) VALUES
('alice', 'scrypt:32768:8:1$PgihPRMtv3PXQXUS$914be02c343fc39fc62f1f758bd45853931d9bd1e356e5f0cf4f161c54c3ca04e2fa9c0923ffca2acad3d0c6c610d6764e7963f52bea16289c72c52ab4d4a768', 'Alice Johnson', 'alice@example.com'),
('bob', 'scrypt:32768:8:1$PgihPRMtv3PXQXUS$914be02c343fc39fc62f1f758bd45853931d9bd1e356e5f0cf4f161c54c3ca04e2fa9c0923ffca2acad3d0c6c610d6764e7963f52bea16289c72c52ab4d4a768', 'Bob Smith', 'bob@example.com'),
('carol', 'scrypt:32768:8:1$PgihPRMtv3PXQXUS$914be02c343fc39fc62f1f758bd45853931d9bd1e356e5f0cf4f161c54c3ca04e2fa9c0923ffca2acad3d0c6c610d6764e7963f52bea16289c72c52ab4d4a768', 'Carol Williams', 'carol@example.com'),
('david', 'scrypt:32768:8:1$PgihPRMtv3PXQXUS$914be02c343fc39fc62f1f758bd45853931d9bd1e356e5f0cf4f161c54c3ca04e2fa9c0923ffca2acad3d0c6c610d6764e7963f52bea16289c72c52ab4d4a768', 'David Brown', 'david@example.com'),
('eve', 'scrypt:32768:8:1$PgihPRMtv3PXQXUS$914be02c343fc39fc62f1f758bd45853931d9bd1e356e5f0cf4f161c54c3ca04e2fa9c0923ffca2acad3d0c6c610d6764e7963f52bea16289c72c52ab4d4a768', 'Eve Davis', 'eve@example.com');

-- Insert 5 Facilities
INSERT INTO facility (name) VALUES
('WiFi'),
('Air Conditioning'),
('TV'),
('Mini Bar'),
('Room Service')
ON DUPLICATE KEY UPDATE name=name;

-- Insert 5 Rooms
INSERT INTO room (room_number, room_type, price_per_night, capacity, status) VALUES
('101', 'Single', 50.00, 1, 'Available'),
('102', 'Single', 50.00, 1, 'Available'),
('201', 'Double', 80.00, 2, 'Available'),
('202', 'Double', 80.00, 2, 'Available'),
('301', 'Suite', 150.00, 4, 'Available');

-- Link facilities to rooms (room_facility)
-- Room 101 gets facilities 1,2,3
INSERT INTO room_facility (room_id, facility_id) VALUES
(1, 1), (1, 2), (1, 3);

-- Room 102 gets facilities 1,2,3,4
INSERT INTO room_facility (room_id, facility_id) VALUES
(2, 1), (2, 2), (2, 3), (2, 4);

-- Room 201 gets facilities 1,2,3,4,5
INSERT INTO room_facility (room_id, facility_id) VALUES
(3, 1), (3, 2), (3, 3), (3, 4), (3, 5);

-- Room 202 gets facilities 1,2,3,5
INSERT INTO room_facility (room_id, facility_id) VALUES
(4, 1), (4, 2), (4, 3), (4, 5);

-- Room 301 gets all facilities
INSERT INTO room_facility (room_id, facility_id) VALUES
(5, 1), (5, 2), (5, 3), (5, 4), (5, 5);

-- Insert 5 Reservations
INSERT INTO reservation (user_id, room_id, check_in, check_out, guests, status, total_cost, payment_status) VALUES
(1, 1, '2025-12-01', '2025-12-03', 1, 'Confirmed', 100.00, 'Paid'),
(2, 2, '2025-12-05', '2025-12-07', 1, 'Confirmed', 100.00, 'Pending'),
(3, 3, '2025-12-10', '2025-12-13', 2, 'Confirmed', 240.00, 'Paid'),
(4, 4, '2025-12-15', '2025-12-17', 2, 'Confirmed', 160.00, 'Pending'),
(5, 5, '2025-12-20', '2025-12-23', 3, 'Confirmed', 450.00, 'Paid');

