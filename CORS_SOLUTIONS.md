# CORS SOLUTIONS FOR FLUTTER WEB DEVELOPMENT

## 🚀 RECOMMENDED SOLUTIONS (Pick One)

### ✅ OPTION 1: Use Enhanced Batch Script (EASIEST)
```bash
# Run this command in your project directory:
.\run_web_dev.bat
```
This script automatically:
- Kills existing Chrome processes
- Launches Chrome with CORS disabled
- Uses temporary profile to avoid conflicts
- Provides detailed logging

### ✅ OPTION 2: Install CORS Chrome Extension (PERMANENT & SIMPLE)
1. Go to Chrome Web Store
2. Install **"CORS Unblock"** or **"Disable CORS"** extension
3. Enable the extension when developing
4. Run normal Flutter command: `flutter run -d chrome`

### ✅ OPTION 3: Create Chrome Shortcut with Flags (PERMANENT)
1. Create a new Chrome shortcut on desktop
2. Right-click → Properties
3. In Target field, add these flags at the end:
   ```
   --disable-web-security --disable-features=VizDisplayCompositor --user-data-dir="C:/temp/chrome_dev"
   ```
4. Full example:
   ```
   "C:\Program Files\Google\Chrome\Application\chrome.exe" --disable-web-security --disable-features=VizDisplayCompositor --user-data-dir="C:/temp/chrome_dev"
   ```

### ✅ OPTION 4: Manual Command Line (FOR TESTING)
```bash
# Kill Chrome first
taskkill /f /im chrome.exe

# Run Flutter with CORS disabled
flutter run -d chrome --web-browser-flag "--disable-web-security" --web-browser-flag "--user-data-dir=C:/temp/chrome_dev_session"
```

---

## 🔧 PRODUCTION SOLUTIONS

### OPTION 5: Backend CORS Configuration (PRODUCTION READY)
Ask your backend team to add these headers to the API server:

```javascript
// Express.js example
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', 'https://yourdomain.com');
  res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');
  
  if (req.method === 'OPTIONS') {
    res.sendStatus(200);
  } else {
    next();
  }
});
```

For **dev.bookiebuddy.in**, the server needs:
```
Access-Control-Allow-Origin: *
Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS
Access-Control-Allow-Headers: Content-Type, Authorization, Accept
```

### OPTION 6: Use Proxy Server (ADVANCED)
Create a proxy server that forwards requests to avoid CORS:

1. Install http-proxy-middleware in a Node.js project
2. Create proxy that forwards localhost:3000 → dev.bookiebuddy.in
3. Update your Flutter app to use localhost:3000

---

## ❗ TROUBLESHOOTING

### If CORS errors persist:
1. **Clear browser cache** completely
2. **Close ALL Chrome instances** before running scripts
3. **Check Windows Defender** - it might block the temp directory
4. **Try different port** - close other apps using Chrome
5. **Use incognito mode** with extensions enabled

### Error: "Chrome didn't start"
```bash
# Try this alternative:
flutter run -d web-server --web-port=8080
# Then open: http://localhost:8080 in Chrome with CORS disabled
```

### Error: "Bad Certificate"
Add this flag to Chrome:
```
--ignore-certificate-errors
```

---

## 📝 CURRENT API ENDPOINT
- **Development API**: `https://dev.bookiebuddy.in/api/v3/`
- **Production API**: `https://flutter.bookiebuddy.in/api/v3/`

The app is currently configured to use the development API endpoint.