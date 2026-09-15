@echo off
title Flutter Web Development Server - CORS Disabled
echo.
echo ============================================
echo  Starting Flutter Web with CORS Disabled
echo ============================================
echo.
echo This script will:
echo - Kill any existing Chrome processes
echo - Launch Chrome with web security disabled
echo - Allow API calls to external domains (dev.bookiebuddy.in)
echo - Use a temporary Chrome profile
echo - Enable all necessary flags for development
echo.

REM Kill any existing Chrome processes to ensure clean start
echo Stopping any running Chrome processes...
taskkill /f /im chrome.exe 2>nul
taskkill /f /im msedge.exe 2>nul
timeout /t 2 /nobreak >nul

REM Create temp directory for Chrome user data
if not exist "C:\temp\chrome_dev_session" mkdir "C:\temp\chrome_dev_session"

REM Clear any existing data in temp directory
echo Clearing temporary Chrome data...
rd /s /q "C:\temp\chrome_dev_session" 2>nul
mkdir "C:\temp\chrome_dev_session" 2>nul

echo.
echo Starting Flutter web app...
echo URL will be: http://localhost:XXXX
echo API calls will be made to: https://dev.bookiebuddy.in
echo.

flutter run -d chrome ^
    --web-browser-flag "--disable-web-security" ^
    --web-browser-flag "--disable-features=VizDisplayCompositor" ^
    --web-browser-flag "--user-data-dir=C:/temp/chrome_dev_session" ^
    --web-browser-flag "--allow-running-insecure-content" ^
    --web-browser-flag "--disable-extensions" ^
    --web-browser-flag "--no-first-run" ^
    --web-browser-flag "--disable-background-timer-throttling" ^
    --web-browser-flag "--disable-backgrounding-occluded-windows" ^
    --web-browser-flag "--disable-renderer-backgrounding" ^
    --web-browser-flag "--disable-ipc-flooding-protection" ^
    --web-browser-flag "--ignore-certificate-errors" ^
    --web-browser-flag "--allow-file-access-from-files"

echo.
echo App stopped. 
echo Cleaning up...
echo.
REM Clean up temp directory when done
rd /s /q "C:\temp\chrome_dev_session" 2>nul
echo Press any key to exit...
pause >nul