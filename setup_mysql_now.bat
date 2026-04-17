@echo off
REM Quick MySQL Setup Script (Batch File - No PowerShell needed)
REM Run this after starting MySQL in XAMPP

echo ========================================
echo MySQL Setup for Hotel DBMS
echo ========================================
echo.

REM Step 1: Create Database
echo Step 1: Creating database 'hotel_dbms'...
echo.

REM Try common XAMPP locations
if exist "C:\xampp\mysql\bin\mysql.exe" (
    echo Found MySQL at C:\xampp\mysql\bin\
    C:\xampp\mysql\bin\mysql.exe -u root -e "CREATE DATABASE IF NOT EXISTS hotel_dbms CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    goto :db_created
)

if exist "D:\xampp\mysql\bin\mysql.exe" (
    echo Found MySQL at D:\xampp\mysql\bin\
    D:\xampp\mysql\bin\mysql.exe -u root -e "CREATE DATABASE IF NOT EXISTS hotel_dbms CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    goto :db_created
)

if exist "E:\xampp\mysql\bin\mysql.exe" (
    echo Found MySQL at E:\xampp\mysql\bin\
    E:\xampp\mysql\bin\mysql.exe -u root -e "CREATE DATABASE IF NOT EXISTS hotel_dbms CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    goto :db_created
)

echo MySQL not found in common locations.
echo.
echo Please create database manually:
echo 1. Open http://localhost/phpmyadmin
echo 2. Click "New" -^> Database name: hotel_dbms -^> Create
echo.
echo Then press any key to continue with driver installation...
pause
goto :install_driver

:db_created
echo Database created successfully!
echo.

:install_driver
REM Step 2: Install pymysql
echo Step 2: Installing MySQL driver (pymysql)...
venv\Scripts\python.exe -m pip install pymysql
echo.

echo ========================================
echo Setup Complete!
echo ========================================
echo.
echo Next steps:
echo 1. Set environment variables (see below)
echo 2. Run: run_app_mysql.bat
echo.
echo Or manually set these in PowerShell:
echo   set DATABASE_TYPE=mysql
echo   set DB_HOST=localhost
echo   set DB_PORT=3306
echo   set DB_USER=root
echo   set DB_PASSWORD=
echo   set DB_NAME=hotel_dbms
echo.
echo Then run: venv\Scripts\python.exe app.py
echo.
pause

