# Database Setup Guide

This guide explains how to connect your Hotel DBMS application to different SQL databases.

## Current Setup

The application now supports:
- **SQLite** (default, for development)
- **MySQL/MariaDB**
- **PostgreSQL**
- **SQL Server**

## Quick Start

### Option 1: Using Environment Variables (Recommended)

1. **Set environment variables** in PowerShell:
   ```powershell
   $env:DATABASE_TYPE="mysql"
   $env:DB_HOST="localhost"
   $env:DB_PORT="3306"
   $env:DB_USER="root"
   $env:DB_PASSWORD="your_password"
   $env:DB_NAME="hotel_dbms"
   ```

2. **Install the database driver**:
   ```powershell
   pip install pymysql  # For MySQL
   # OR
   pip install psycopg2-binary  # For PostgreSQL
   # OR
   pip install pyodbc  # For SQL Server
   ```

3. **Create the database** (if it doesn't exist):
   ```sql
   CREATE DATABASE hotel_dbms;
   ```

4. **Run the application**:
   ```powershell
   python app.py
   ```

### Option 2: Using .env File (Alternative)

1. Install python-dotenv:
   ```powershell
   pip install python-dotenv
   ```

2. Create a `.env` file in the project root:
   ```
   DATABASE_TYPE=mysql
   DB_HOST=localhost
   DB_PORT=3306
   DB_USER=root
   DB_PASSWORD=your_password
   DB_NAME=hotel_dbms
   ```

3. Update `app.py` to load from .env (add at the top):
   ```python
   from dotenv import load_dotenv
   load_dotenv()
   ```

## Database-Specific Setup

### MySQL/MariaDB

1. **Install MySQL Server** (if not installed):
   - Download from: https://dev.mysql.com/downloads/mysql/
   - Or use XAMPP/WAMP which includes MySQL

2. **Install Python driver**:
   ```powershell
   pip install pymysql
   ```

3. **Create database**:
   ```sql
   CREATE DATABASE hotel_dbms CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ```

4. **Set environment variables**:
   ```powershell
   $env:DATABASE_TYPE="mysql"
   $env:DB_HOST="localhost"
   $env:DB_PORT="3306"
   $env:DB_USER="root"
   $env:DB_PASSWORD="your_mysql_password"
   $env:DB_NAME="hotel_dbms"
   ```

### PostgreSQL

1. **Install PostgreSQL** (if not installed):
   - Download from: https://www.postgresql.org/download/

2. **Install Python driver**:
   ```powershell
   pip install psycopg2-binary
   ```

3. **Create database**:
   ```sql
   CREATE DATABASE hotel_dbms;
   ```

4. **Set environment variables**:
   ```powershell
   $env:DATABASE_TYPE="postgresql"
   $env:DB_HOST="localhost"
   $env:DB_PORT="5432"
   $env:DB_USER="postgres"
   $env:DB_PASSWORD="your_postgres_password"
   $env:DB_NAME="hotel_dbms"
   ```

### SQL Server

1. **Install SQL Server** (if not installed):
   - Download SQL Server Express: https://www.microsoft.com/en-us/sql-server/sql-server-downloads
   - Or use SQL Server Developer Edition (free)

2. **Install ODBC Driver**:
   - Download: https://docs.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server

3. **Install Python driver**:
   ```powershell
   pip install pyodbc
   ```

4. **Create database**:
   ```sql
   CREATE DATABASE hotel_dbms;
   ```

5. **Set environment variables**:
   ```powershell
   $env:DATABASE_TYPE="mssql"
   $env:DB_HOST="localhost"
   $env:DB_PORT="1433"
   $env:DB_USER="sa"
   $env:DB_PASSWORD="your_sql_server_password"
   $env:DB_NAME="hotel_dbms"
   ```

## Database Connection Strings

The application automatically generates connection strings based on your configuration:

- **SQLite**: `sqlite:///hotel.db`
- **MySQL**: `mysql+pymysql://user:password@host:port/database`
- **PostgreSQL**: `postgresql://user:password@host:port/database`
- **SQL Server**: `mssql+pyodbc://user:password@host:port/database?driver=ODBC+Driver+17+for+SQL+Server`

## Initializing the Database

When you run the application for the first time with a new database:

1. The `init_db()` function will automatically:
   - Create all tables
   - Create a default admin user (username: `admin`, password: `admin123`)

2. If you need to reset the database:
   ```python
   # In Python shell or add to app.py temporarily
   from app import app, db
   with app.app_context():
       db.drop_all()
       db.create_all()
   ```

## Troubleshooting

### Connection Errors

1. **Check database is running**:
   - MySQL: `mysql -u root -p`
   - PostgreSQL: `psql -U postgres`
   - SQL Server: Check SQL Server Management Studio

2. **Verify credentials**:
   - Test connection with database client tools
   - Check firewall settings

3. **Check port numbers**:
   - MySQL: 3306 (default)
   - PostgreSQL: 5432 (default)
   - SQL Server: 1433 (default)

### Driver Installation Issues

- **MySQL**: If `pymysql` doesn't work, try `mysqlclient` (requires MySQL dev libraries)
- **PostgreSQL**: `psycopg2-binary` is pre-compiled, easier than `psycopg2`
- **SQL Server**: Ensure ODBC Driver is installed before `pyodbc`

### Permission Errors

- Ensure database user has CREATE, INSERT, UPDATE, DELETE permissions
- For MySQL: `GRANT ALL PRIVILEGES ON hotel_dbms.* TO 'user'@'localhost';`

## Testing the Connection

You can test your database connection by running:

```python
from app import app, db
with app.app_context():
    try:
        db.engine.connect()
        print("Database connection successful!")
    except Exception as e:
        print(f"Connection failed: {e}")
```

