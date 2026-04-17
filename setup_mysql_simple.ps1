# Simple MySQL Setup Script
# This script will help you set up MySQL connection

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Hotel DBMS - Simple MySQL Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if MySQL is available
$mysqlPath = $null

# Check common MySQL locations
$possiblePaths = @(
    "C:\xampp\mysql\bin\mysql.exe",
    "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe",
    "C:\Program Files\MySQL\MySQL Server 8.4\bin\mysql.exe",
    "C:\wamp64\bin\mysql\mysql8.0.xx\bin\mysql.exe"
)

foreach ($path in $possiblePaths) {
    if (Test-Path $path) {
        $mysqlPath = $path
        Write-Host "✓ Found MySQL at: $path" -ForegroundColor Green
        break
    }
}

if (-not $mysqlPath) {
    Write-Host "⚠ MySQL not found in common locations" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Option 1: Install XAMPP from https://www.apachefriends.org/" -ForegroundColor White
    Write-Host "Option 2: Install MySQL from https://dev.mysql.com/downloads/mysql/" -ForegroundColor White
    Write-Host "Option 3: Use SQLite (no setup needed) - just run: python app.py" -ForegroundColor White
    Write-Host ""
    Write-Host "For now, let's configure for MySQL and you can create the database manually." -ForegroundColor Yellow
    Write-Host ""
}

# Set environment variables
$env:DATABASE_TYPE = "mysql"
$env:DB_HOST = "localhost"
$env:DB_PORT = "3306"
$env:DB_USER = "root"
$env:DB_PASSWORD = ""
$env:DB_NAME = "hotel_dbms"

Write-Host "Environment variables set:" -ForegroundColor Green
Write-Host "  DATABASE_TYPE = $env:DATABASE_TYPE"
Write-Host "  DB_HOST = $env:DB_HOST"
Write-Host "  DB_PORT = $env:DB_PORT"
Write-Host "  DB_USER = $env:DB_USER"
Write-Host "  DB_PASSWORD = (empty)"
Write-Host "  DB_NAME = $env:DB_NAME"
Write-Host ""

if ($mysqlPath) {
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Creating database..." -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Cyan
    
    # Create database
    $createDbCmd = "CREATE DATABASE IF NOT EXISTS hotel_dbms CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    & $mysqlPath -u root -e $createDbCmd
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Database 'hotel_dbms' created successfully!" -ForegroundColor Green
        Write-Host ""
        Write-Host "Next: Install MySQL driver and run Flask app" -ForegroundColor Yellow
        Write-Host "  pip install pymysql" -ForegroundColor White
        Write-Host "  python app.py" -ForegroundColor White
        Write-Host ""
        Write-Host "Flask will automatically create all tables!" -ForegroundColor Green
    } else {
        Write-Host "⚠ Could not create database. You may need to:" -ForegroundColor Yellow
        Write-Host "  1. Start MySQL service" -ForegroundColor White
        Write-Host "  2. Check MySQL password" -ForegroundColor White
        Write-Host "  3. Create database manually" -ForegroundColor White
    }
} else {
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Manual Setup Required" -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "To create the database manually:" -ForegroundColor White
    Write-Host ""
    Write-Host "1. Start MySQL (via XAMPP or MySQL service)" -ForegroundColor White
    Write-Host "2. Open MySQL command line or any MySQL client" -ForegroundColor White
    Write-Host "3. Run: CREATE DATABASE hotel_dbms;" -ForegroundColor White
    Write-Host "4. Then run: pip install pymysql" -ForegroundColor White
    Write-Host "5. Then run: python app.py" -ForegroundColor White
    Write-Host ""
    Write-Host "Flask will automatically create all tables!" -ForegroundColor Green
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Ready to continue!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan

