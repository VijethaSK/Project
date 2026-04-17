# Quick Setup - Without phpMyAdmin

If you can't access phpMyAdmin, here are alternative ways to set up your database:

## Option 1: Using MySQL Command Line (Easiest)

### Step 1: Open MySQL Command Line

**If XAMPP is installed:**
```powershell
cd C:\xampp\mysql\bin
.\mysql.exe -u root
```

**If MySQL is installed separately:**
```powershell
mysql -u root -p
```
(Enter password if you set one, or press Enter if no password)

### Step 2: Create Database and Import Schema

Once in MySQL, run:
```sql
CREATE DATABASE IF NOT EXISTS hotel_dbms CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE hotel_dbms;
```

Then copy and paste the entire contents of `schema_mysql.sql` into the MySQL command line, or:

```sql
SOURCE D:/DBMS/DBMS/schema_mysql.sql;
```

(Adjust the path to where your schema_mysql.sql file is located)

### Step 3: Verify Tables Created

```sql
SHOW TABLES;
```

You should see:
- admin
- facility
- reservation
- room
- room_facility
- user

### Step 4: Exit MySQL

```sql
EXIT;
```

## Option 2: Using a Single Command (PowerShell)

If MySQL is in your PATH, you can run:

```powershell
# Navigate to your project folder
cd D:\DBMS\DBMS

# Create database
C:\xampp\mysql\bin\mysql.exe -u root -e "CREATE DATABASE IF NOT EXISTS hotel_dbms CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

# Import schema
C:\xampp\mysql\bin\mysql.exe -u root hotel_dbms < schema_mysql.sql
```

## Option 3: Let Flask Create Tables Automatically

If you just want to get started quickly:

1. **Create only the database:**
   ```powershell
   C:\xampp\mysql\bin\mysql.exe -u root -e "CREATE DATABASE IF NOT EXISTS hotel_dbms CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
   ```

2. **Set environment variables:**
   ```powershell
   $env:DATABASE_TYPE="mysql"
   $env:DB_HOST="localhost"
   $env:DB_PORT="3306"
   $env:DB_USER="root"
   $env:DB_PASSWORD=""
   $env:DB_NAME="hotel_dbms"
   ```

3. **Install MySQL driver:**
   ```powershell
   .\venv\Scripts\activate
   pip install pymysql
   ```

4. **Run Flask app - it will create tables automatically:**
   ```powershell
   python app.py
   ```

Flask will automatically create all tables when you first run the app!

## Troubleshooting phpMyAdmin Access

If you want to use phpMyAdmin but can't access it:

1. **Check if Apache is running in XAMPP Control Panel**
   - Open XAMPP Control Panel
   - Click "Start" next to Apache
   - Wait for it to turn green

2. **Try different URLs:**
   - `http://localhost/phpmyadmin`
   - `http://127.0.0.1/phpmyadmin`
   - `http://localhost:8080/phpmyadmin` (if Apache is on port 8080)

3. **Check if XAMPP is installed:**
   - Look for XAMPP folder in `C:\xampp\`
   - If not installed, download from: https://www.apachefriends.org/

4. **Use MySQL Workbench or DBeaver instead:**
   - Download MySQL Workbench: https://dev.mysql.com/downloads/workbench/
   - Connect to: `localhost:3306`, user: `root`, password: (empty)
   - Create database and import schema

## Quick Test

After setup, test your connection:

```powershell
python test_db_connection.py
```

You should see:
```
✅ Database connection successful!
✅ Database query test successful!
```

