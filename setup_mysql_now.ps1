# Quick MySQL Setup Script
# Run this after starting MySQL in XAMPP

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "MySQL Setup for Hotel DBMS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Find MySQL
$mysqlPath = $null
$possiblePaths = @(
    "C:\xampp\mysql\bin\mysql.exe",
    "C:\Program Files\xampp\mysql\bin\mysql.exe",
    "D:\xampp\mysql\bin\mysql.exe",
    "E:\xampp\mysql\bin\mysql.exe"
)

Write-Host "Searching for MySQL..." -ForegroundColor Yellow
foreach ($path in $possiblePaths) {
    if (Test-Path $path) {
        $mysqlPath = $path
        Write-Host "✓ Found MySQL at: $path" -ForegroundColor Green
        break
    }
}

if (-not $mysqlPath) {
    Write-Host "✗ MySQL not found in common locations" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please tell me where XAMPP is installed, or:" -ForegroundColor Yellow
    Write-Host "1. Open phpMyAdmin: http://localhost/phpmyadmin" -ForegroundColor White
    Write-Host "2. Click 'New' → Database name: hotel_dbms → Create" -ForegroundColor White
    Write-Host ""
    Write-Host "Then continue to Step 3 below" -ForegroundColor Yellow
    exit
}

# Step 1: Create Database
Write-Host ""
Write-Host "Step 1: Creating database 'hotel_dbms'..." -ForegroundColor Yellow
& $mysqlPath -u root -e "CREATE DATABASE IF NOT EXISTS hotel_dbms CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Database created successfully!" -ForegroundColor Green
} else {
    Write-Host "✗ Failed to create database" -ForegroundColor Red
    Write-Host "Make sure MySQL is running in XAMPP Control Panel" -ForegroundColor Yellow
    exit
}

# Step 2: Install pymysql
Write-Host ""
Write-Host "Step 2: Installing MySQL driver (pymysql)..." -ForegroundColor Yellow
.\venv\Scripts\python.exe -m pip install pymysql

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ pymysql installed successfully!" -ForegroundColor Green
} else {
    Write-Host "✗ Failed to install pymysql" -ForegroundColor Red
    exit
}

# Step 3: Set environment variables
Write-Host ""
Write-Host "Step 3: Setting environment variables..." -ForegroundColor Yellow
$env:DATABASE_TYPE = "mysql"
$env:DB_HOST = "localhost"
$env:DB_PORT = "3306"
$env:DB_USER = "root"
$env:DB_PASSWORD = ""
$env:DB_NAME = "hotel_dbms"

Write-Host "✓ Environment variables set!" -ForegroundColor Green

# Step 4: Test connection
Write-Host ""
Write-Host "Step 4: Testing database connection..." -ForegroundColor Yellow
.\venv\Scripts\python.exe test_db_connection.py

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next: Run your Flask app:" -ForegroundColor Yellow
Write-Host "  .\venv\Scripts\python.exe app.py" -ForegroundColor White
Write-Host ""
Write-Host "Or use: run_app_mysql.bat" -ForegroundColor White
Write-Host ""

