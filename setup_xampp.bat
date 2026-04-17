@echo off
REM Quick setup script for XAMPP MySQL connection
REM Run this before starting your Flask app

echo ========================================
echo Hotel DBMS - XAMPP MySQL Setup
echo ========================================
echo.

REM Set environment variables for MySQL/XAMPP
set DATABASE_TYPE=mysql
set DB_HOST=localhost
set DB_PORT=3306
set DB_USER=root
set DB_PASSWORD=
set DB_NAME=hotel_dbms

echo Environment variables set:
echo   DATABASE_TYPE=%DATABASE_TYPE%
echo   DB_HOST=%DB_HOST%
echo   DB_PORT=%DB_PORT%
echo   DB_USER=%DB_USER%
echo   DB_PASSWORD=%DB_PASSWORD%
echo   DB_NAME=%DB_NAME%
echo.

echo ========================================
echo Next steps:
echo 1. Make sure MySQL is running in XAMPP
echo 2. Create database: hotel_dbms (if not exists)
echo 3. Import schema_mysql.sql via phpMyAdmin
echo 4. Run: python test_db_connection.py
echo 5. Run: python app.py
echo ========================================
echo.

REM Keep the environment variables for this session
echo Environment variables are set for this PowerShell session.
echo You can now run: python app.py
echo.

pause

