@echo off
REM Simple batch file to run the Flask app
REM This avoids PowerShell execution policy issues

echo Starting Hotel DBMS Application...
echo.

REM Set MySQL environment variables (change if needed)
set DATABASE_TYPE=sqlite
set DB_HOST=localhost
set DB_PORT=3306
set DB_USER=root
set DB_PASSWORD=
set DB_NAME=hotel_dbms

echo Database: SQLite (no setup needed)
echo.
echo Starting Flask server...
echo Access at: http://127.0.0.1:5000/
echo.
echo Press Ctrl+C to stop the server
echo.

REM Run using venv's Python directly
venv\Scripts\python.exe app.py

