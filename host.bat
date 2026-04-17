@echo off
REM Production Hosting Script for Windows CMD
REM This script starts the Hotel DBMS application using Waitress production server

echo ========================================
echo Hotel DBMS - Production Server
echo ========================================
echo.

REM Check if virtual environment exists
if not exist "venv\Scripts\python.exe" (
    echo Creating virtual environment...
    python -m venv venv
    echo Installing dependencies...
    venv\Scripts\python.exe -m pip install --upgrade pip
    venv\Scripts\pip.exe install -r requirements.txt
)

echo.
echo Starting production server...
echo Access at: http://localhost:5000/
echo.
echo Press Ctrl+C to stop the server
echo ========================================
echo.

REM Start the server
venv\Scripts\python.exe host.py

