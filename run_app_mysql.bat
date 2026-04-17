@echo off
REM Batch file to run Flask app with MySQL
REM Make sure MySQL is running and database 'hotel_dbms' exists

echo ========================================
echo Starting Hotel DBMS Application (MySQL)
echo ========================================
echo.

REM Set MySQL environment variables
set DATABASE_TYPE=mysql
set DB_HOST=localhost
set DB_PORT=3306
set DB_USER=root
set DB_PASSWORD=
set DB_NAME=hotel_dbms

echo Database Configuration:
echo   Type: MySQL
echo   Host: localhost
echo   Database: hotel_dbms
echo   User: root
echo.

echo Starting Flask server...
echo Access at: http://127.0.0.1:5000/
echo.
echo Default Admin Login:
echo   Username: admin
echo   Password: admin123
echo.
echo Press Ctrl+C to stop the server
echo.

REM Run using venv's Python directly
venv\Scripts\python.exe app.py

