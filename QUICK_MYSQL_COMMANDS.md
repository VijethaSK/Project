# Quick MySQL Commands Reference

## Access MySQL Command Line

**Option 1: Use the batch file**
```cmd
mysql_command.bat
```

**Option 2: Use full path**
```cmd
D:\xampp\mysql\bin\mysql.exe -u root
```

**Option 3: Navigate to MySQL folder first**
```cmd
cd D:\xampp\mysql\bin
mysql.exe -u root
```

## Once Inside MySQL

### Basic Commands

```sql
-- Switch to your database
USE hotel_dbms;

-- Show all tables
SHOW TABLES;

-- View table structure
DESCRIBE room;
DESCRIBE user;
DESCRIBE reservation;

-- View all data in a table
SELECT * FROM room;
SELECT * FROM user;
SELECT * FROM admin;
SELECT * FROM reservation;
SELECT * FROM facility;

-- Count records
SELECT COUNT(*) FROM room;
SELECT COUNT(*) FROM reservation;

-- View specific columns
SELECT room_number, room_type, price_per_night FROM room;

-- Exit MySQL
EXIT;
```

### Useful Queries

```sql
-- View all available rooms
SELECT * FROM room WHERE status = 'Available';

-- View all confirmed reservations
SELECT * FROM reservation WHERE status = 'Confirmed';

-- View reservations with room details
SELECT r.id, r.check_in, r.check_out, ro.room_number, ro.room_type, u.username
FROM reservation r
JOIN room ro ON r.room_id = ro.id
JOIN user u ON r.user_id = u.id;

-- View rooms with their facilities
SELECT ro.room_number, ro.room_type, f.name as facility
FROM room ro
LEFT JOIN room_facility rf ON ro.id = rf.room_id
LEFT JOIN facility f ON rf.facility_id = f.id;
```

## Alternative: Use phpMyAdmin (Easier!)

Instead of command line, use the web interface:
- URL: `http://localhost/phpmyadmin`
- Select `hotel_dbms` database
- Click on any table to view/edit data
- Use "SQL" tab to run queries

