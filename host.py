"""
Production Hosting Script for Hotel DBMS
Uses Waitress - a production WSGI server for Windows
"""
import os
import socket
from waitress import serve
from app import app, init_db


def get_local_ip():
    """Get the local IP address"""
    try:
        # Connect to a remote address to determine local IP
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        ip = s.getsockname()[0]
        s.close()
        return ip
    except Exception:
        return "localhost"


if __name__ == "__main__":
    # Initialize database
    with app.app_context():
        init_db()
    
    # Get configuration from environment variables
    host = os.getenv("HOST", "0.0.0.0")  # 0.0.0.0 to accept connections from any IP
    port = int(os.getenv("PORT", 5000))
    threads = int(os.getenv("THREADS", 4))
    
    print("=" * 50)
    print("Hotel DBMS - Production Server")
    print("=" * 50)
    print(f"Host: {host}")
    print(f"Port: {port}")
    print(f"Threads: {threads}")
    print(f"Access URL: http://localhost:{port}/")
    print(f"Network URL: http://{get_local_ip()}:{port}/")
    print("=" * 50)
    print("Press Ctrl+C to stop the server")
    print("=" * 50)
    
    # Start production server
    serve(app, host=host, port=port, threads=threads)

