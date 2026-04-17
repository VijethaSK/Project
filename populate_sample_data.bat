@echo off
REM This will run Flask app which automatically creates default admin user
REM Or you can add sample data manually

echo ========================================
echo Populating Database with Data
echo ========================================
echo.
echo Option 1: Run Flask App (Recommended)
echo   - Creates default admin user automatically
echo   - Login: admin / admin123
echo   - Then add rooms/facilities through the web interface
echo.
echo Option 2: Add sample data via SQL (see below)
echo.
echo Running Flask app now...
echo   (This will create the default admin user)
echo.
echo Press Ctrl+C to stop after admin is created
echo   Or keep it running to use the web interface
echo.

REM Set MySQL environment variables
set DATABASE_TYPE=mysql
set DB_HOST=localhost
set DB_PORT=3306
set DB_USER=root
set DB_PASSWORD=
set DB_NAME=hotel_dbms

REM Run Flask - it will create admin user on first run
venv\Scripts\python.exe app.py

