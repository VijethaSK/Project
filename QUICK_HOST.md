# Quick Hosting Guide

## 🚀 Fastest Way to Host

### Step 1: Install Dependencies

```powershell
.\venv\Scripts\activate
pip install -r requirements.txt
```

### Step 2: Run Production Server

**Option A: Using PowerShell Script (Recommended)**
```powershell
.\host.ps1
```

**Option B: Using Batch File**
```cmd
host.bat
```

**Option C: Direct Python**
```powershell
python host.py
```

### Step 3: Access Your App

- Local: `http://localhost:5000/`
- Network: Check the console for your network IP (e.g., `http://192.168.1.100:5000/`)

## 🌐 Make It Accessible on Your Network

The server automatically binds to `0.0.0.0`, so other devices on your WiFi can access it:
1. Find your IP address (shown when server starts)
2. Access from phone/tablet: `http://YOUR_IP:5000/`

## 🌍 Make It Public (Internet Access)

### Using ngrok (Easiest)

1. Download ngrok: https://ngrok.com/download
2. Run your app: `python host.py`
3. In new terminal: `ngrok http 5000`
4. Copy the public URL (e.g., `https://abc123.ngrok.io`)

## ⚙️ Configuration (Optional)

Create a `.env` file to customize:

```env
SECRET_KEY=your-secret-key-here
HOST=0.0.0.0
PORT=5000
THREADS=4
DATABASE_TYPE=sqlite
```

## 📋 Default Admin Login

- Username: `admin`
- Password: `admin123`

**Change this in production!**

## 🆘 Troubleshooting

**Port already in use?**
- Change PORT in `.env` file to another number (e.g., 8000)

**Can't access from network?**
- Check Windows Firewall settings
- Make sure server shows "Host: 0.0.0.0"

**Need help?**
- See `HOSTING.md` for detailed documentation

