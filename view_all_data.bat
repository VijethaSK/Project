@echo off
REM Quick script to view all data in MySQL database

echo ========================================
echo Viewing All Data in hotel_dbms Database
echo ========================================
echo.

REM Try to find MySQL
if exist "D:\xampp\mysql\bin\mysql.exe" (
    set MYSQL_PATH=D:\xampp\mysql\bin\mysql.exe
    goto :run_queries
)

if exist "C:\xampp\mysql\bin\mysql.exe" (
    set MYSQL_PATH=C:\xampp\mysql\bin\mysql.exe
    goto :run_queries
)

echo MySQL not found!
pause
exit

:run_queries
echo Running queries to view all data...
echo.

echo [1] All Users:
%MYSQL_PATH% -u root -e "USE hotel_dbms; SELECT * FROM user;"
echo.

echo [2] All Admins:
%MYSQL_PATH% -u root -e "USE hotel_dbms; SELECT * FROM admin;"
echo.

echo [3] All Rooms:
%MYSQL_PATH% -u root -e "USE hotel_dbms; SELECT * FROM room;"
echo.

echo [4] All Facilities:
%MYSQL_PATH% -u root -e "USE hotel_dbms; SELECT * FROM facility;"
echo.

echo [5] All Reservations:
%MYSQL_PATH% -u root -e "USE hotel_dbms; SELECT * FROM reservation;"
echo.

echo [6] Record Counts:
%MYSQL_PATH% -u root -e "USE hotel_dbms; SELECT 'user' AS table_name, COUNT(*) AS count FROM user UNION ALL SELECT 'admin', COUNT(*) FROM admin UNION ALL SELECT 'room', COUNT(*) FROM room UNION ALL SELECT 'facility', COUNT(*) FROM facility UNION ALL SELECT 'room_facility', COUNT(*) FROM room_facility UNION ALL SELECT 'reservation', COUNT(*) FROM reservation;"
echo.

echo ========================================
echo Done! For more detailed queries, see view_all_data.sql
echo ========================================
echo.
pause

