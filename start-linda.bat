@echo off
title Linda — Land Indicator
cd /d "C:\Users\ofirm\.linda-local"

:: Open browser after a short delay (gives servers time to start)
start "" cmd /c "timeout /t 4 /noexec >nul & start http://localhost:5173"

:: Start both client and server
npm run dev

pause
