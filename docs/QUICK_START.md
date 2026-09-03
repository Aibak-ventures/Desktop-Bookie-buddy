# 🚀 Quick Start Guide - Fix CORS Issues

## ⚡ IMMEDIATE SOLUTION (Choose One)

### Option 1: Use the Enhanced Script (Easiest)
```bash
# Double-click this file in your project folder:
run_web_dev.bat
```

### Option 2: Use the Interactive Helper
```bash
# Double-click this file for a menu of options:
dev_helper.bat
```

### Option 3: Manual Command (Advanced Users)
```bash
# Close all Chrome windows first, then run:
flutter run -d chrome --web-browser-flag "--disable-web-security" --web-browser-flag "--user-data-dir=C:/temp/chrome_dev"
```

---

## 🔍 What Was Fixed

1. **Enhanced Dio Configuration**
   - Better CORS error detection
   - Improved logging for debugging
   - Proper timeout handling
   - Better error messages

2. **Improved Error Handling**
   - More specific CORS error messages
   - Better server response parsing
   - Detailed logging in development mode
   - Graceful fallbacks for production

3. **Development Scripts**
   - `run_web_dev.bat` - Enhanced with better Chrome handling
   - `dev_helper.bat` - Interactive menu for different options
   - Automatic Chrome process cleanup

4. **Better API Service**
   - Added retry logic
   - Improved error handling with `safeApiCall`
   - Network connectivity checking
   - Enhanced logging

---

## 📋 Quick Checklist

✅ Make sure Chrome is completely closed before running scripts  
✅ Windows Defender/Antivirus might block temp folder creation  
✅ Try different Chrome flags if one doesn't work  
✅ Install CORS browser extension as permanent solution  
✅ Check your internet connection  

---

## 🆘 Still Having Issues?

### Common Problems & Solutions:

**"Chrome didn't start"**
- Close all Chrome instances manually
- Run as administrator
- Try Edge instead: `flutter run -d edge --web-browser-flag "--disable-web-security"`

**"Permission denied on temp folder"**
- Run command prompt as administrator
- Change temp directory in scripts to a different location
- Check antivirus settings

**"API still failing"**
- Verify the API endpoint is working: https://dev.bookiebuddy.in/api/v3/
- Check your internet connection
- Try using a VPN if there are regional restrictions

**"CORS errors persist"**
- Install a CORS browser extension
- Clear all browser cache and cookies
- Try incognino mode with extensions enabled

---

## 🔧 For Production

To permanently fix CORS for production, your backend team needs to add these headers to the API server (dev.bookiebuddy.in):

```
Access-Control-Allow-Origin: https://yourdomain.com
Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS
Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept, Authorization
```

---

## 📞 Need Help?

If you're still stuck:
1. Check the detailed error messages in the console
2. Try the interactive `dev_helper.bat` script
3. Install a CORS browser extension
4. Contact the backend team about CORS headers

Happy coding! 🎉