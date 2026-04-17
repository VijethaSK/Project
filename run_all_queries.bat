@echo off
REM Run all SQL queries from complete_sql_reference.sql
echo Running all SQL queries...
echo.

D:\xampp\mysql\bin\mysql.exe -u root hotel_dbms_new < complete_sql_reference.sql

if %ERRORLEVEL% EQU 0 (
    echo.
    echo [OK] All queries executed successfully!
    echo.
    echo Views created. You can now query them:
    echo   SELECT * FROM v_reservation_summary;
    echo   SELECT * FROM v_available_rooms;
    echo   SELECT * FROM v_user_bookings;
) else (
    echo.
    echo [ERROR] Some queries failed. Check the error messages above.
)

pause

