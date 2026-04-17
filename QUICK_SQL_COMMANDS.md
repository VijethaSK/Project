# Quick SQL Commands to View All Data

## Quick Access Methods

### Method 1: Use the Batch File (Easiest)
```cmd
view_all_data.bat
```
This will show all data from all tables automatically.

### Method 2: MySQL Command Line
```cmd
D:\xampp\mysql\bin\mysql.exe -u root hotel_dbms
```

### Method 3: phpMyAdmin
- Go to: `http://localhost/phpmyadmin`
- Select `hotel_dbms` database
- Click on any table to view data

---

## Individual Table Queries

### View All Users
```sql
USE hotel_dbms;
SELECT * FROM user;
```

### View All Admins
```sql
SELECT * FROM admin;
```

### View All Rooms
```sql
SELECT * FROM room;
```

### View All Facilities
```sql
SELECT * FROM facility;
```

### View All Reservations
```sql
SELECT * FROM reservation;
```

### View Room-Facility Relationships
```sql
SELECT 
    r.room_number,
    r.room_type,
    f.name AS facility
FROM room r
JOIN room_facility rf ON r.id = rf.room_id
JOIN facility f ON rf.facility_id = f.id
ORDER BY r.room_number;
```

---

## Detailed Queries

### Reservations with User and Room Details
```sql
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
    res.payment_status
FROM reservation res
JOIN user u ON res.user_id = u.id
JOIN room r ON res.room_id = r.id
ORDER BY res.created_at DESC;
```

### Rooms with All Facilities
```sql
SELECT 
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
```

### Count Records in All Tables
```sql
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
```

---

## Filtered Queries

### Available Rooms Only
```sql
SELECT * FROM room WHERE status = 'Available';
```

### Confirmed Reservations Only
```sql
SELECT * FROM reservation WHERE status = 'Confirmed';
```

### Reservations by User
```sql
SELECT * FROM reservation WHERE user_id = 1;
```

### Rooms by Type
```sql
SELECT * FROM room WHERE room_type = 'Suite';
```

---

## One-Line Commands (PowerShell/CMD)

### View All Tables
```cmd
D:\xampp\mysql\bin\mysql.exe -u root -e "USE hotel_dbms; SHOW TABLES;"
```

### View All Rooms
```cmd
D:\xampp\mysql\bin\mysql.exe -u root -e "USE hotel_dbms; SELECT * FROM room;"
```

### View All Users
```cmd
D:\xampp\mysql\bin\mysql.exe -u root -e "USE hotel_dbms; SELECT * FROM user;"
```

### View All Reservations
```cmd
D:\xampp\mysql\bin\mysql.exe -u root -e "USE hotel_dbms; SELECT * FROM reservation;"
```

### Count All Records
```cmd
D:\xampp\mysql\bin\mysql.exe -u root -e "USE hotel_dbms; SELECT 'user' AS table_name, COUNT(*) AS count FROM user UNION ALL SELECT 'admin', COUNT(*) FROM admin UNION ALL SELECT 'room', COUNT(*) FROM room UNION ALL SELECT 'facility', COUNT(*) FROM facility UNION ALL SELECT 'reservation', COUNT(*) FROM reservation;"
```

