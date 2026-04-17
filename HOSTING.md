# Hosting Guide - Hotel DBMS Application

This guide explains how to host your Hotel DBMS Flask application in production.

## Quick Start - Local Hosting

### Option 1: Development Server (Quick Testing)

```powershell
# Activate virtual environment
.\venv\Scripts\activate

# Run development server
python app.py
```

Access at: `http://localhost:5000/`

### Option 2: Production Server (Recommended)

```powershell
# Activate virtual environment
.\venv\Scripts\activate

# Install dependencies (if not already installed)
pip install -r requirements.txt

# Run production server
python host.py
```

Access at: `http://localhost:5000/`

## Production Configuration

### 1. Create `.env` File

Create a `.env` file in the project root directory:

```env
# Secret Key (change this to a random string in production!)
SECRET_KEY=your-super-secret-key-change-this-in-production

# Server Configuration
HOST=0.0.0.0
PORT=5000
THREADS=4

# Database Configuration
DATABASE_TYPE=sqlite

# For MySQL/MariaDB:
# DATABASE_TYPE=mysql
# DB_HOST=localhost
# DB_PORT=3306
# DB_USER=root
# DB_PASSWORD=your_password
# DB_NAME=hotel_dbms

# For PostgreSQL:
# DATABASE_TYPE=postgresql
# DB_HOST=localhost
# DB_PORT=5432
# DB_USER=postgres
# DB_PASSWORD=your_password
# DB_NAME=hotel_dbms
```

### 2. Run Production Server

```powershell
python host.py
```

## Hosting on Network (Same WiFi)

The production server is configured to accept connections from any IP address (`0.0.0.0`), so other devices on your network can access it:

1. Find your computer's local IP address (displayed when starting the server)
2. Access from other devices: `http://YOUR_IP:5000/`

**Example:**
- Your computer IP: `192.168.1.100`
- Access URL: `http://192.168.1.100:5000/`

## Hosting on the Internet

### Option 1: Using ngrok (Quick Testing)

1. Download ngrok from: https://ngrok.com/
2. Run your Flask app: `python host.py`
3. In a new terminal, run: `ngrok http 5000`
4. Copy the public URL (e.g., `https://abc123.ngrok.io`)

### Option 2: Using Cloud Platforms

#### Heroku

1. Install Heroku CLI: https://devcenter.heroku.com/articles/heroku-cli
2. Create `Procfile`:
   ```
   web: waitress-serve --host=0.0.0.0 --port=$PORT host:app
   ```
3. Deploy:
   ```powershell
   heroku create your-app-name
   heroku config:set SECRET_KEY=your-secret-key
   git push heroku main
   ```

#### PythonAnywhere

1. Sign up at: https://www.pythonanywhere.com/
2. Upload your files
3. Configure WSGI file to point to your `app` object
4. Reload your web app

#### Railway

1. Sign up at: https://railway.app/
2. Connect your GitHub repository
3. Set environment variables
4. Deploy automatically

#### Render

1. Sign up at: https://render.com/
2. Create a new Web Service
3. Connect your repository
4. Set environment variables
5. Deploy

## Security Checklist for Production

- [ ] Change `SECRET_KEY` to a random string
- [ ] Set `DEBUG=False` (add to `.env`: `FLASK_ENV=production`)
- [ ] Use strong database passwords
- [ ] Enable HTTPS (SSL/TLS certificate)
- [ ] Set up firewall rules
- [ ] Use environment variables for sensitive data
- [ ] Regularly update dependencies
- [ ] Set up database backups

## Environment Variables Reference

| Variable | Description | Default |
|----------|-------------|---------|
| `SECRET_KEY` | Flask secret key for sessions | `dev-secret-key-change-me-in-production` |
| `HOST` | Server host | `0.0.0.0` |
| `PORT` | Server port | `5000` |
| `THREADS` | Number of worker threads | `4` |
| `DATABASE_TYPE` | Database type: sqlite, mysql, postgresql, mssql | `sqlite` |
| `DB_HOST` | Database host | `localhost` |
| `DB_PORT` | Database port | Database specific |
| `DB_USER` | Database username | Database specific |
| `DB_PASSWORD` | Database password | - |
| `DB_NAME` | Database name | `hotel_dbms` |

## Troubleshooting

### Port Already in Use

If port 5000 is already in use, change it in `.env`:
```env
PORT=8000
```

### Database Connection Issues

1. Check database is running
2. Verify credentials in `.env` file
3. Ensure database exists
4. Check firewall settings

### Can't Access from Network

1. Check Windows Firewall settings
2. Ensure server is binding to `0.0.0.0` (not `127.0.0.1`)
3. Verify network connection

## Default Admin Credentials

After first run, default admin credentials:
- Username: `admin`
- Password: `admin123`

**⚠️ IMPORTANT: Change the admin password in production!**

