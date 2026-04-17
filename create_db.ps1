# Create MySQL Database - Simple Script
# This tries to create the database using MySQL command line

Write-Host "Creating MySQL database..." -ForegroundColor Cyan
Write-Host ""

# Try to find MySQL
$mysqlPath = $null
$possiblePaths = @(
    "C:\xampp\mysql\bin\mysql.exe",
    "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe",
    "C:\Program Files\MySQL\MySQL Server 8.4\bin\mysql.exe"
)

foreach ($path in $possiblePaths) {
    if (Test-Path $path) {
        $mysqlPath = $path
        Write-Host "Found MySQL at: $path" -ForegroundColor Green
        break
    }
}

if ($mysqlPath) {
    Write-Host "Creating database 'hotel_dbms'..." -ForegroundColor Yellow
    & $mysqlPath -u root -e "CREATE DATABASE IF NOT EXISTS hotel_dbms CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Database created successfully!" -ForegroundColor Green
        Write-Host ""
        Write-Host "Next step: Run .\run_app.ps1" -ForegroundColor Cyan
    } else {
        Write-Host "✗ Failed to create database" -ForegroundColor Red
        Write-Host "Make sure MySQL is running in XAMPP Control Panel" -ForegroundColor Yellow
    }
} else {
    Write-Host "MySQL not found in common locations." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Option 1: Install XAMPP from https://www.apachefriends.org/" -ForegroundColor White
    Write-Host "Option 2: Use SQLite instead (no MySQL needed):" -ForegroundColor White
    Write-Host "   Run: .\run_app_sqlite.ps1" -ForegroundColor Cyan
}

