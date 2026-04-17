# Setting Up Hotel DBMS with XAMPP (MySQL)

This guide will help you set up your Hotel DBMS application with MySQL using XAMPP.

## Prerequisites

1. **Install XAMPP** (if not already installed)
   - Download from: https://www.apachefriends.org/
   - Install and start Apache and MySQL from XAMPP Control Panel

2. **Install Python MySQL Driver**
   ```powershell
   .\venv\Scripts\activate
   pip install pymysql
   ```

## Step-by-Step Setup

### Step 1: Start MySQL in XAMPP

1. Open **XAMPP Control Panel**
2. Click **Start** next to **MySQL**
3. MySQL should now be running on port 3306

### Step 2: Create the Database

**Option A: Using phpMyAdmin (Easiest)**

1. Open your browser and go to: `http://localhost/phpmyadmin`
2. Click on **"New"** in the left sidebar
3. Enter database name: `hotel_dbms`
4. Select collation: `utf8mb4_unicode_ci`
5. Click **"Create"**

**Option B: Using MySQL Command Line**

1. Open Command Prompt or PowerShell
2. Navigate to XAMPP MySQL bin folder:
   ```powershell
   cd C:\xampp\mysql\bin
   ```
3. Connect to MySQL (default: no password):
   ```powershell
   mysql.exe -u root
   ```
4. Create the database:
   ```sql
   CREATE DATABASE hotel_dbms CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   USE hotel_dbms;
   ```
5. Exit MySQL:
   ```sql
   EXIT;
   ```

### Step 3: Import the Schema

**Option A: Using phpMyAdmin**

1. Go to `http://localhost/phpmyadmin`
2. Select `hotel_dbms` database from the left sidebar
3. Click on **"Import"** tab
4. Click **"Choose File"** and select `schema_mysql.sql`
5. Click **"Go"** at the bottom
6. You should see "Import has been successfully finished"

**Option B: Using MySQL Command Line**

1. Open Command Prompt/PowerShell
2. Navigate to your project directory:
   ```powershell
   cd D:\DBMS\DBMS
   ```
3. Import the schema:
   ```powershell
   C:\xampp\mysql\bin\mysql.exe -u root hotel_dbms < schema_mysql.sql
   ```

**Option C: Copy and Paste SQL**

1. Open `schema_mysql.sql` in a text editor
2. Copy all the SQL code
3. Go to phpMyAdmin → Select `hotel_dbms` → Click **"SQL"** tab
4. Paste the SQL code
5. Click **"Go"**

### Step 4: Configure Your Flask App

Set environment variables in PowerShell:

```powershell
$env:DATABASE_TYPE="mysql"
$env:DB_HOST="localhost"
$env:DB_PORT="3306"
$env:DB_USER="root"
$env:DB_PASSWORD=""  # Leave empty if no password set in XAMPP
$env:DB_NAME="hotel_dbms"
```

**Note:** If you set a password for MySQL root user, include it in `DB_PASSWORD`.

### Step 5: Test the Connection

```powershell
python test_db_connection.py
```

You should see:
```
✅ Database connection successful!
✅ Database query test successful!
```

### Step 6: Run Your Application

```powershell
python app.py
```

The app will:
- Connect to MySQL database
- Create tables if they don't exist (via Flask-SQLAlchemy)
- Create default admin user (username: `admin`, password: `admin123`)

## Default XAMPP MySQL Settings

- **Host:** `localhost` or `127.0.0.1`
- **Port:** `3306`
- **Username:** `root`
- **Password:** (usually empty/blank by default)

## Troubleshooting

### "Access denied for user 'root'@'localhost'"

**Solution:** Set a password or reset MySQL password:
1. Stop MySQL in XAMPP
2. Open XAMPP Control Panel → MySQL → Config → my.ini
3. Add this line under `[mysqld]`:
   ```
   skip-grant-tables
   ```
4. Start MySQL
5. Connect: `mysql.exe -u root`
6. Run: `ALTER USER 'root'@'localhost' IDENTIFIED BY '';` (empty password)
7. Remove the `skip-grant-tables` line
8. Restart MySQL

### "Can't connect to MySQL server"

**Solution:**
1. Check if MySQL is running in XAMPP Control Panel
2. Verify port 3306 is not blocked by firewall
3. Try `127.0.0.1` instead of `localhost`

### "Unknown database 'hotel_dbms'"

**Solution:** Create the database first (see Step 2)

### "Table already exists"

**Solution:** The tables are already created. You can either:
- Drop and recreate: `DROP DATABASE hotel_dbms; CREATE DATABASE hotel_dbms;`
- Or just run the app - Flask will handle existing tables

## Viewing Your Data

You can view and manage your database using phpMyAdmin:
- URL: `http://localhost/phpmyadmin`
- Select `hotel_dbms` database
- Browse tables, run queries, export data, etc.

## Next Steps

1. ✅ Database created
2. ✅ Tables imported
3. ✅ Flask app configured
4. ✅ Test connection
5. ✅ Run application
6. 🎉 Access at `http://127.0.0.1:5000/`

## Useful MySQL Commands

```sql
-- View all databases
SHOW DATABASES;

-- Use a database
USE hotel_dbms;

-- View all tables
SHOW TABLES;

-- View table structure
DESCRIBE user;

-- View all users
SELECT * FROM user;

-- View all rooms
SELECT * FROM room;

-- View all reservations
SELECT * FROM reservation;
```

