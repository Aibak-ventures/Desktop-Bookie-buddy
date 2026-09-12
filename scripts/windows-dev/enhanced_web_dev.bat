@echo off
title Flutter Web Dev - CORS Disabled
color 0A

echo.
echo ============================================
echo   FLUTTER WEB DEVELOPMENT SERVER
echo ============================================
echo.
echo Starting with CORS disabled for API calls...
echo.

REM Kill any existing Chrome processes to ensure clean start
taskkill /f /im chrome.exe >nul 2>&1

REM Wait a moment for processes to close
timeout /t 2 /nobreak >nul

REM Create temp directory for Chrome user data
if not exist "C:\temp\flutter_chrome_dev" mkdir "C:\temp\flutter_chrome_dev"

echo Starting Flutter app with enhanced Chrome flags...
echo.

flutter run -d chrome ^
  --web-browser-flag="--disable-web-security" ^
  --web-browser-flag="--disable-features=VizDisplayCompositor" ^
  --web-browser-flag="--user-data-dir=C:/temp/flutter_chrome_dev" ^
  --web-browser-flag="--allow-running-insecure-content" ^
  --web-browser-flag="--disable-extensions" ^
  --web-browser-flag="--no-first-run" ^
  --web-browser-flag="--ignore-certificate-errors" ^
  --web-browser-flag="--ignore-ssl-errors" ^
  --web-browser-flag="--ignore-certificate-errors-spki-list"

echo.
echo App closed. Press any key to exit...
pause >nul