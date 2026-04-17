# Step-by-Step Setup: Connect Flask to MySQL (XAMPP)

Follow these steps in order:

## ✅ Step 1: Start MySQL in XAMPP (YOU'VE DONE THIS!)
- Open XAMPP Control Panel
- Click "Start" next to MySQL
- Wait until it turns green

## Step 2: Create the Database

**Option A: Using Command Line (Easiest)**

1. Open PowerShell
2. Navigate to your project:
   ```powershell
   cd D:\DBMS\DBMS
   ```
3. Create the database:
   ```powershell
   C:\xampp\mysql\bin\mysql.exe -u root -e "CREATE DATABASE hotel_dbms CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
   ```

**Option B: Using phpMyAdmin**

1. Open browser: `http://localhost/phpmyadmin`
2. Click "New" in left sidebar
3. Database name: `hotel_dbms`
4. Collation: `utf8mb4_unicode_ci`
5. Click "Create"

**Option C: Manual MySQL Command**

1. Open Command Prompt
2. Go to MySQL:
   ```cmd
   cd C:\xampp\mysql\bin
   mysql.exe -u root
   ```
3. Run:
   ```sql
   CREATE DATABASE hotel_dbms CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   EXIT;
   ```

## Step 3: Install MySQL Driver for Python

In PowerShell:
```powershell
cd D:\DBMS\DBMS
.\venv\Scripts\python.exe -m pip install pymysql
```

## Step 4: Set Environment Variables

In PowerShell:
```powershell
$env:DATABASE_TYPE="mysql"
$env:DB_HOST="localhost"
$env:DB_PORT="3306"
$env:DB_USER="root"
$env:DB_PASSWORD=""  # Empty if no password
$env:DB_NAME="hotel_dbms"
```

## Step 5: Test Database Connection

```powershell
.\venv\Scripts\python.exe test_db_connection.py
```

You should see:
```
✅ Database connection successful!
✅ Database query test successful!
```

## Step 6: Run Your Flask App

```powershell
.\venv\Scripts\python.exe app.py
```

OR use the batch file:
```cmd
run_app_mysql.bat
```

## Step 7: Access Your App

Open browser: `http://127.0.0.1:5000/`

---

## Troubleshooting

**"Access denied for user 'root'@'localhost'"**
- MySQL might have a password. Try:
  ```powershell
  $env:DB_PASSWORD="your_password"
  ```

**"Can't connect to MySQL server"**
- Make sure MySQL is running in XAMPP Control Panel
- Check if port 3306 is correct

**"Unknown database 'hotel_dbms'"**
- Go back to Step 2 and create the database

