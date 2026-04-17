# Run Hotel DBMS App - No venv activation needed
# This script sets up MySQL connection and runs the Flask app

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Starting Hotel DBMS Application" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Set MySQL environment variables
$env:DATABASE_TYPE = "mysql"
$env:DB_HOST = "localhost"
$env:DB_PORT = "3306"
$env:DB_USER = "root"
$env:DB_PASSWORD = ""
$env:DB_NAME = "hotel_dbms"

Write-Host "Database Configuration:" -ForegroundColor Green
Write-Host "  Type: MySQL" -ForegroundColor White
Write-Host "  Host: localhost" -ForegroundColor White
Write-Host "  Database: hotel_dbms" -ForegroundColor White
Write-Host ""

Write-Host "Note: Make sure MySQL is running and database 'hotel_dbms' exists" -ForegroundColor Yellow
Write-Host ""

# Run the app using venv's Python directly
Write-Host "Starting Flask application..." -ForegroundColor Green
Write-Host "Access at: http://127.0.0.1:5000/" -ForegroundColor Cyan
Write-Host ""

.\venv\Scripts\python.exe app.py

