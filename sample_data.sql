-- Sample Data for Hotel DBMS
-- Run this after tables are created to add sample data

USE hotel_dbms;

-- Insert default admin (password: admin123)
-- Note: This hash is for 'admin123' - Flask will create this automatically
-- But you can also insert it manually if needed
INSERT INTO admin (username, password_hash, full_name, email) 
VALUES ('admin', 'pbkdf2:sha256:600000$...', 'Default Admin', 'admin@example.com')
ON DUPLICATE KEY UPDATE username=username;

-- Insert sample facilities
INSERT INTO facility (name) VALUES 
('WiFi'),
('Air Conditioning'),
('TV'),
('Mini Bar'),
('Room Service'),
('Breakfast'),
('Pool Access'),
('Parking')
ON DUPLICATE KEY UPDATE name=name;

-- Insert sample rooms
INSERT INTO room (room_number, room_type, price_per_night, capacity, status) VALUES
('101', 'Single', 50.00, 1, 'Available'),
('102', 'Single', 50.00, 1, 'Available'),
('201', 'Double', 80.00, 2, 'Available'),
('202', 'Double', 80.00, 2, 'Available'),
('301', 'Suite', 150.00, 4, 'Available'),
('302', 'Suite', 150.00, 4, 'Available'),
('401', 'Deluxe', 120.00, 3, 'Available'),
('402', 'Deluxe', 120.00, 3, 'Available')
ON DUPLICATE KEY UPDATE room_number=room_number;

-- Link facilities to rooms
-- Room 101 (Single) - Basic facilities
INSERT INTO room_facility (room_id, facility_id) VALUES
(1, 1), (1, 2), (1, 3)
ON DUPLICATE KEY UPDATE room_id=room_id;

-- Room 201 (Double) - More facilities
INSERT INTO room_facility (room_id, facility_id) VALUES
(3, 1), (3, 2), (3, 3), (3, 4), (3, 5)
ON DUPLICATE KEY UPDATE room_id=room_id;

-- Room 301 (Suite) - All facilities
INSERT INTO room_facility (room_id, facility_id) VALUES
(5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (5, 8)
ON DUPLICATE KEY UPDATE room_id=room_id;

-- Note: The admin password hash above is a placeholder
-- Flask will create the admin user with proper hash when you run the app

