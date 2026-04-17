"""
Test database connection script
Run this to verify your database configuration is correct
"""
import os
from app import app, db

def test_connection():
    """Test database connection"""
    with app.app_context():
        try:
            # Try to connect
            connection = db.engine.connect()
            print("[OK] Database connection successful!")
            db_uri = app.config['SQLALCHEMY_DATABASE_URI']
            if '@' in db_uri:
                print(f"   Database: {db_uri.split('@')[-1]}")
            else:
                print(f"   Database: {db_uri}")
            
            # Try a simple query
            from sqlalchemy import text
            result = connection.execute(text("SELECT 1"))
            result.fetchone()
            print("[OK] Database query test successful!")
            
            connection.close()
            return True
            
        except Exception as e:
            print(f"[ERROR] Database connection failed!")
            print(f"   Error: {str(e)}")
            print("\nTroubleshooting:")
            print("1. Check if your database server is running")
            print("2. Verify your database credentials (DB_USER, DB_PASSWORD, DB_NAME)")
            print("3. Ensure the database exists (CREATE DATABASE hotel_dbms;)")
            print("4. Check if the required driver is installed:")
            print("   - MySQL: pip install pymysql")
            print("   - PostgreSQL: pip install psycopg2-binary")
            print("   - SQL Server: pip install pyodbc")
            return False

if __name__ == "__main__":
    print("Testing database connection...")
    print(f"Database Type: {os.getenv('DATABASE_TYPE', 'sqlite')}")
    print("-" * 50)
    test_connection()

