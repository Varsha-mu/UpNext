@echo off
echo ===================================================
echo        Starting UpNext Feedback Platform
echo ===================================================

echo 1. Checking MongoDB Database on port 27017...
netstat -ano | findstr "LISTENING" | findstr "27017" >nul
if %errorlevel% neq 0 (
    echo    MongoDB engine is not running. Starting local database...
    start "UpNext MongoDB Database" /min "C:\Users\varsh\.cache\mongodb-binaries\mongod-x64-win32-7.0.24.exe" --dbpath "%~dp0server\data\db" --port 27017 --bind_ip 127.0.0.1
    timeout /t 2 /nobreak >nul
) else (
    echo    MongoDB is running and active on port 27017.
)

echo 2. Starting Backend API on port 5000...
start "UpNext Backend API" cmd /k "cd /d %~dp0server && npm run dev"

echo 3. Starting Frontend Web App on port 3000...
start "UpNext Frontend App" cmd /k "cd /d %~dp0client && npm run dev"

echo.
echo ===================================================
echo All UpNext services successfully launched!
echo - Web App:        http://localhost:3000
echo - Admin Portal:   http://localhost:3000/admin/login
echo - Backend API:    http://localhost:5000/api
echo - Database URI:   mongodb://127.0.0.1:27017/upnext
echo ===================================================
echo.
pause
