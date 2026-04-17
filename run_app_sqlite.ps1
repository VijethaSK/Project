# Run Hotel DBMS App with SQLite (No MySQL needed)
# This is the simplest option - no database setup required

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Starting Hotel DBMS Application (SQLite)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Don't set DATABASE_TYPE - defaults to SQLite
# Or explicitly set to sqlite
$env:DATABASE_TYPE = "sqlite"

Write-Host "Database: SQLite (hotel.db)" -ForegroundColor Green
Write-Host "No setup required - database will be created automatically!" -ForegroundColor Green
Write-Host ""

Write-Host "Starting Flask application..." -ForegroundColor Green
Write-Host "Access at: http://127.0.0.1:5000/" -ForegroundColor Cyan
Write-Host ""

.\venv\Scripts\python.exe app.py

