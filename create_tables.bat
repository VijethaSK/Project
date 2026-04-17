@echo off
REM Create database tables - Option 1: Import SQL schema
echo Creating tables from schema_mysql.sql...
echo.

REM Method 1: Using MySQL command with input redirection
D:\xampp\mysql\bin\mysql.exe -u root hotel_dbms < schema_mysql.sql

if %ERRORLEVEL% EQU 0 (
    echo.
    echo [OK] Tables created successfully!
    echo.
    echo Next: Run your Flask app to populate initial data
    echo   run_app_mysql.bat
) else (
    echo.
    echo [INFO] If import failed, Flask will create tables automatically when you run the app
    echo   Just run: run_app_mysql.bat
)

pause

