# Build Scripts for Different Environments

## 🌍 Environment Files Setup
Make sure you have the following files:
- `.env.development` - For local development
- `.env.staging` - For staging environment  
- `.env.production` - For production environment

## 🚀 Development Commands

### Web Development
```bash
flutter run -d chrome --dart-define=FLAVOR=development
```

### Web Staging
```bash
flutter run -d chrome --dart-define=FLAVOR=staging
```

### Web Production
```bash
flutter run -d chrome --dart-define=FLAVOR=production
```

### Mobile Development
```bash
flutter run --dart-define=FLAVOR=development
```

## 🏗️ Build Commands

### Development Build (Web)
```bash
flutter build web --dart-define=FLAVOR=development --web-renderer canvaskit
```

### Staging Build (Web)
```bash
flutter build web --dart-define=FLAVOR=staging --web-renderer canvaskit
```

### Production Build (Web)
```bash
flutter build web --dart-define=FLAVOR=production --web-renderer canvaskit --release
```

### Development Build (Mobile)
```bash
# Android
flutter build apk --dart-define=FLAVOR=development

# iOS
flutter build ios --dart-define=FLAVOR=development
```

### Staging Build (Mobile)
```bash
# Android
flutter build apk --dart-define=FLAVOR=staging

# iOS  
flutter build ios --dart-define=FLAVOR=staging
```

### Production Build (Mobile)
```bash
# Android
flutter build apk --dart-define=FLAVOR=production --release

# iOS
flutter build ios --dart-define=FLAVOR=production --release
```

## 🎯 VS Code Usage

1. Press `F5` or go to **Run and Debug**
2. Select from dropdown:
   - 🚀 **Flutter (Development)** - Loads `.env.development`
   - 🧪 **Flutter (Staging)** - Loads `.env.staging`
   - 🏭 **Flutter (Production)** - Loads `.env.production`

## 🔐 Environment Variables Structure

### .env.development
```env
ENV=development
BASE_URL=https://dev-api.bookingapp.com
RAZORPAY_KEY=rzp_test_dev_key
ENABLE_DEBUG_LOGS=true
ENABLE_MOCK_DATA=true
```

### .env.staging
```env
ENV=staging
BASE_URL=https://staging-api.bookingapp.com
RAZORPAY_KEY=rzp_test_staging_key
ENABLE_DEBUG_LOGS=true
ENABLE_MOCK_DATA=false
```

### .env.production
```env
ENV=production
BASE_URL=https://api.bookingapp.com
RAZORPAY_KEY=rzp_live_prod_key
SENTRY_DSN=https://your-sentry-dsn@sentry.io/project-id
ENABLE_DEBUG_LOGS=false
ENABLE_MOCK_DATA=false
```

## 🚀 CI/CD Pipeline Integration

### GitHub Actions Example
```yaml
- name: Build Development
  run: flutter build web --dart-define=FLAVOR=development

- name: Build Production  
  run: flutter build web --dart-define=FLAVOR=production --release
  env:
    RAZORPAY_KEY: ${{ secrets.RAZORPAY_PROD_KEY }}
    SENTRY_DSN: ${{ secrets.SENTRY_DSN }}
```

## 🔧 Debugging

### Check Current Environment
```bash
flutter run -d chrome --dart-define=FLAVOR=development
# Look for console output:
# ✅ Loaded environment: .env.development
# 🌍 Current Environment: development
# 🔗 Base URL: https://dev-api.bookingapp.com
```

### Validate Environment
The app will automatically validate required environment variables on startup and show errors if any are missing.
