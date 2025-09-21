@echo off
echo Starting Flutter Web Development Server with CORS disabled...
echo This allows API calls to work during development
echo.
flutter run -d chrome --web-browser-flag "--disable-web-security" --web-browser-flag "--disable-features=VizDisplayCompositor" --web-port=8080
