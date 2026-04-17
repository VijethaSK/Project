# Quick Start Guide

## To Start Your Flask App:

### Method 1: Double-Click Batch File (Easiest)
1. Double-click `run_app_mysql.bat` in Windows Explorer
2. Keep the window open
3. Wait for: "Running on http://127.0.0.1:5000"
4. Open browser: `http://127.0.0.1:5000/`

### Method 2: Command Line
Open Command Prompt or PowerShell:
```cmd
cd D:\DBMS\DBMS
run_app_mysql.bat
```

### Method 3: Manual (if batch file doesn't work)
```cmd
cd D:\DBMS\DBMS
set DATABASE_TYPE=mysql
set DB_HOST=localhost
set DB_PORT=3306
set DB_USER=root
set DB_PASSWORD=
set DB_NAME=hotel_dbms
venv\Scripts\python.exe app.py
```

## Important:
- **Keep the terminal window open** while the app is running
- Don't close it or the server will stop
- Press Ctrl+C to stop the server

## Troubleshooting:

**"ERR_CONNECTION_REFUSED"**
- Make sure the Flask app is running
- Check the terminal window for errors
- Wait 10-15 seconds after starting

**"ModuleNotFoundError"**
- Make sure you're using: `venv\Scripts\python.exe app.py`
- NOT: `python app.py`

**"Can't connect to MySQL"**
- Make sure MySQL is running in XAMPP Control Panel
- Check that database `hotel_dbms` exists

## Default Login:
- Username: `admin`
- Password: `admin123`

