@echo off
title Flutter Web Development Helper
color 0A

:menu
cls
echo.
echo ========================================
echo    Flutter Web Development Helper
echo ========================================
echo.
echo Choose your development option:
echo.
echo 1. Run with CORS disabled (Recommended)
echo 2. Run normal Flutter web
echo 3. Check Chrome processes
echo 4. Clear Chrome temp data
echo 5. Install CORS extension guide
echo 6. Exit
echo.
set /p choice="Enter your choice (1-6): "

if "%choice%"=="1" goto cors_disabled
if "%choice%"=="2" goto normal_run
if "%choice%"=="3" goto check_processes
if "%choice%"=="4" goto clear_data
if "%choice%"=="5" goto extension_guide
if "%choice%"=="6" goto exit
echo Invalid choice. Please try again.
pause
goto menu

:cors_disabled
cls
echo.
echo ==========================================
echo     Running Flutter Web (CORS Disabled)
echo ==========================================
echo.
echo Stopping any running Chrome processes...
taskkill /f /im chrome.exe 2>nul
taskkill /f /im msedge.exe 2>nul
timeout /t 2 /nobreak >nul

echo Creating temporary Chrome profile...
if not exist "C:\temp\chrome_dev_session" mkdir "C:\temp\chrome_dev_session"

echo.
echo Starting Flutter app with CORS disabled...
echo This will allow API calls to: https://dev.bookiebuddy.in
echo.
flutter run -d chrome ^
    --web-browser-flag "--disable-web-security" ^
    --web-browser-flag "--disable-features=VizDisplayCompositor" ^
    --web-browser-flag "--user-data-dir=C:/temp/chrome_dev_session" ^
    --web-browser-flag "--allow-running-insecure-content" ^
    --web-browser-flag "--ignore-certificate-errors"

echo.
echo Cleaning up temporary data...
rd /s /q "C:\temp\chrome_dev_session" 2>nul
pause
goto menu

:normal_run
cls
echo.
echo ========================================
echo      Running Flutter Web (Normal)
echo ========================================
echo.
echo NOTE: This may cause CORS errors when calling APIs.
echo Make sure you have CORS extension installed or
echo backend has CORS headers configured.
echo.
flutter run -d chrome
pause
goto menu

:check_processes
cls
echo.
echo ========================================
echo       Checking Chrome Processes
echo ========================================
echo.
echo Current Chrome processes:
tasklist | findstr /i chrome.exe
echo.
echo Current Edge processes:
tasklist | findstr /i msedge.exe
echo.
echo Press any key to continue...
pause
goto menu

:clear_data
cls
echo.
echo ========================================
echo      Clearing Chrome Temp Data
echo ========================================
echo.
echo Stopping Chrome processes...
taskkill /f /im chrome.exe 2>nul
timeout /t 2 /nobreak >nul

echo Clearing temporary Chrome data...
rd /s /q "C:\temp\chrome_dev_session" 2>nul
rd /s /q "C:\temp\chrome_dev" 2>nul

echo Temporary data cleared successfully!
echo.
pause
goto menu

:extension_guide
cls
echo.
echo ========================================
echo      CORS Extension Installation
echo ========================================
echo.
echo To install a CORS extension:
echo.
echo 1. Open Chrome and go to Chrome Web Store
echo 2. Search for "CORS Unblock" or "Disable CORS"
echo 3. Install the extension
echo 4. Enable the extension when developing
echo 5. Run: flutter run -d chrome (normal command)
echo.
echo Popular CORS extensions:
echo - CORS Unblock
echo - Disable CORS
echo - CORS Toggle
echo.
echo After installing, you won't need special command flags!
echo.
pause
goto menu

:exit
echo.
echo Goodbye! Happy coding!
timeout /t 2 /nobreak >nul
exit
