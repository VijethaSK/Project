# Production Hosting Script for Windows PowerShell
# This script starts the Hotel DBMS application using Waitress production server

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Hotel DBMS - Production Server" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if virtual environment exists
if (-Not (Test-Path "venv\Scripts\python.exe")) {
    Write-Host "❌ Virtual environment not found!" -ForegroundColor Red
    Write-Host "Creating virtual environment..." -ForegroundColor Yellow
    python -m venv venv
    Write-Host "Installing dependencies..." -ForegroundColor Yellow
    .\venv\Scripts\python.exe -m pip install --upgrade pip
    .\venv\Scripts\pip.exe install -r requirements.txt
}

# Load environment variables from .env if it exists
if (Test-Path ".env") {
    Write-Host "Loading environment variables from .env file..." -ForegroundColor Green
    Get-Content .env | ForEach-Object {
        if ($_ -match '^([^#][^=]+)=(.*)$') {
            $key = $matches[1].Trim()
            $value = $matches[2].Trim()
            [Environment]::SetEnvironmentVariable($key, $value, "Process")
        }
    }
} else {
    Write-Host "⚠️  .env file not found. Using default configuration." -ForegroundColor Yellow
    Write-Host "   Create a .env file for custom configuration." -ForegroundColor Yellow
}

# Set default environment variables if not set
if (-Not $env:HOST) { $env:HOST = "0.0.0.0" }
if (-Not $env:PORT) { $env:PORT = "5000" }
if (-Not $env:DATABASE_TYPE) { $env:DATABASE_TYPE = "sqlite" }
if (-Not $env:SECRET_KEY) { $env:SECRET_KEY = "dev-secret-key-change-me-in-production" }

Write-Host ""
Write-Host "Configuration:" -ForegroundColor Green
Write-Host "  Host: $env:HOST" -ForegroundColor White
Write-Host "  Port: $env:PORT" -ForegroundColor White
Write-Host "  Database: $env:DATABASE_TYPE" -ForegroundColor White
Write-Host ""
Write-Host "Starting production server..." -ForegroundColor Green
Write-Host "Access at: http://localhost:$env:PORT/" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Start the server
.\venv\Scripts\python.exe host.py

