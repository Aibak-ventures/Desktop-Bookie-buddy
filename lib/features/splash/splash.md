# Splash Feature

App entry point. Decides which screen to navigate to based on local storage state.

---

## Responsibilities

- Display the branded splash screen while the app initialises
- Check whether the user has completed onboarding
- Check whether a valid session token exists
- Navigate to the correct screen: Onboarding → Login → Home

---

## Directory Structure

```
splash/
├── domain/
│   └── usecases/
│       └── splash_initialization_usecase.dart   # Routing logic; 2-second delay
└── presentation/
    └── pages/
        └── splash_screen.dart                   # StatefulWidget; calls use case on init
```

No data layer — the use case reads directly from `SharedPreferenceHelper` and `SessionStorage`.

---

## Key Flow

```
SplashScreen.initState
  → SplashInitializationUseCase.call()
    → await Future.delayed(2 seconds)
    → SharedPreferenceHelper.getBool(AppConstants.onboardingKey)
      → false → navigatorKey.pushReplacement(OnboardingScreen)
    → SessionStorage.hasTokens()
      → false → navigatorKey.pushReplacement(LoginScreen)
      → true  → navigatorKey.pushReplacement(BottomBarScreen)
```

---

## API Endpoints

None — splash is entirely local.

---

## Dependencies

| Dependency | Source |
|---|---|
| `SharedPreferenceHelper` | `lib/utils/shared_preference_helper.dart` |
| `SessionStorage` | `lib/core/session/` |
| `navigatorKey` | Global key from `MyApp` |

---

## Gotchas

- **No BLoC** — routing logic lives in a use case and is called directly from `initState`. This is intentional; there is no state to manage beyond the navigation decision.
- **Domain accesses local storage directly** — the use case bypasses the repository pattern in favour of simplicity. This is acceptable for app initialisation logic that has no testable business rules.
