@echo off
REM Quick script to open database access options

echo ========================================
echo Database Access Options
echo ========================================
echo.
echo Option 1: phpMyAdmin (Web Interface)
echo   URL: http://localhost/phpmyadmin
echo   Opening in browser...
echo.
start http://localhost/phpmyadmin
echo.
echo Option 2: MySQL Command Line
echo   Run: D:\xampp\mysql\bin\mysql.exe -u root
echo   Then: USE hotel_dbms;
echo.
echo Option 3: View through Flask App
echo   URL: http://127.0.0.1:5000/admin/dashboard
echo   Login: admin / admin123
echo.
echo ========================================
echo.
echo Database Name: hotel_dbms
echo Tables: user, admin, room, facility, reservation, room_facility
echo.
pause

