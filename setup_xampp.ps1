# PowerShell script to set up XAMPP MySQL connection
# Run this in PowerShell: .\setup_xampp.ps1

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Hotel DBMS - XAMPP MySQL Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Set environment variables for MySQL/XAMPP
$env:DATABASE_TYPE = "mysql"
$env:DB_HOST = "localhost"
$env:DB_PORT = "3306"
$env:DB_USER = "root"
$env:DB_PASSWORD = ""  # Leave empty if no password
$env:DB_NAME = "hotel_dbms"

Write-Host "Environment variables set:" -ForegroundColor Green
Write-Host "  DATABASE_TYPE = $env:DATABASE_TYPE"
Write-Host "  DB_HOST = $env:DB_HOST"
Write-Host "  DB_PORT = $env:DB_PORT"
Write-Host "  DB_USER = $env:DB_USER"
Write-Host "  DB_PASSWORD = $env:DB_PASSWORD"
Write-Host "  DB_NAME = $env:DB_NAME"
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Make sure MySQL is running in XAMPP" -ForegroundColor White
Write-Host "2. Create database: hotel_dbms (if not exists)" -ForegroundColor White
Write-Host "3. Import schema_mysql.sql via phpMyAdmin" -ForegroundColor White
Write-Host "4. Test connection: python test_db_connection.py" -ForegroundColor White
Write-Host "5. Run app: python app.py" -ForegroundColor White
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Environment variables are set for this PowerShell session." -ForegroundColor Green
Write-Host "You can now run: python app.py" -ForegroundColor Green
Write-Host ""

