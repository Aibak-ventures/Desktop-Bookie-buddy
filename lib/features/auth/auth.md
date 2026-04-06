# Auth Feature

Handles user authentication, session lifecycle, and password management for the Bookie Buddy app.

---

## Responsibilities

- Phone + password login and secure token storage
- Secondary ("secret/wallet") password authentication
- User profile fetching and active shop management
- FCM push notification token registration, removal, and shop-switch update
- Account password and secret password changes
- Full logout — clears tokens, cache, and preferences

---

## Directory Structure

```
auth/
├── data/
│   ├── datasources/
│   │   ├── auth_remote_datasource.dart      # Login, secret login, password changes, token refresh
│   │   └── user_remote_datasource.dart      # Fetch profile, FCM token register/remove/update
│   └── repositories/
│       ├── auth_repository_impl.dart        # Saves access/refresh tokens after login
│       └── user_repository_impl.dart        # Logout, shop switch, FCM, shopId persistence
├── domain/
│   ├── repositories/
│   │   ├── i_auth_repository.dart           # login, secretLogin, refreshToken, changePasswords
│   │   └── i_user_repository.dart           # fetchUserData, logout, shopId, FCM, switchShop
│   └── usecases/
│       ├── login_usecase.dart
│       ├── logout_usecase.dart
│       ├── get_user_usecase.dart
│       ├── change_account_password_usecase.dart
│       ├── change_secret_password_usecase.dart
│       ├── register_fcm_token_usecase.dart
│       └── switch_shop_usecase.dart
└── presentation/
    ├── bloc/
    │   ├── auth_bloc/                        # Login flow
    │   ├── reset_password_bloc/              # Account password change
    │   ├── secret_password_bloc/             # Secret password change
    │   └── user_cubit/                       # Global user state (UserEntity?)
    └── pages/
        ├── onboarding_screen.dart
        ├── login_screen.dart
        ├── reset_password_screen.dart
        └── change_secret_password_screen.dart
```

---

## Key Flows

### Login
```
LoginScreen
  → AuthBloc.loginRequested(phone, password, fcmToken?)
    → LoginUseCase → IAuthRepository.login()
      → POST /api/v3/auth/login/
      → SessionStorage.saveTokens(access, refresh)
  → AuthState.authenticated
    → UserCubit.loadUserData()        # fetches profile, persists shopId
    → Navigator → BottomBarScreen
```

### Logout
```
UserCubit.logOut(fcmToken?)
  → LogoutUseCase → IUserRepository.logout()
    → POST /api/v3/notifications/device-tokens/remove/
    → SessionStorage cleared (tokens, shopId)
    → SharedPreferences cleared
    → Cache cleared
  → UserCubit emits null → App navigates to LoginScreen
```

### Shop Switch
```
UserCubit.switchShop(shopId, fcmToken?)
  → SwitchShopUseCase
    → POST /api/v3/notifications/device-tokens/update-shop/   # if fcmToken provided
    → IUserRepository.switchShop(shopId)
      → SharedPreferences.setShopId(shopId)
      → GET /api/v4/auth/profile/                             # re-fetch for new shop
  → UserCubit emits updated UserEntity
```

### Token Refresh
```
AuthInterceptor (DioClient) — triggered automatically on 401
  → IAuthRepository.refreshToken()
    → POST /api/v1/token/refresh/
    → SessionStorage.saveAccessToken(newToken)
```

---

## State Management

### `AuthBloc`

| Event | Description | Resulting State |
|---|---|---|
| `loginRequested` | Login button tapped | `loading` → `authenticated` or `error` |

### `ResetPasswordBloc`

| Event | Description | Resulting State |
|---|---|---|
| `resetPassword` | Submit on ResetPasswordScreen | `submitted` → `success` or `error` |

> Validates `oldPassword != newPassword` before calling the use case.

### `SecretPasswordBloc`

| Event | Description | Resulting State |
|---|---|---|
| `submitPasswordChange` | Submit on ChangeSecretPasswordScreen | `loading` → `success` or `failure` |

### `UserCubit` — State: `UserEntity?`

Provided globally via `BlocProvider` in `MyApp`. Null when logged out.

| Method | Description |
|---|---|
| `loadUserData()` | Fetches profile, stores shopId, emits `UserEntity` |
| `loadUserIfNot()` | Lazy load — skips if state already set |
| `logOut({fcmToken?})` | Full logout, emits null |
| `switchShop(shopId, fcmToken?)` | Updates shopId, re-fetches profile, emits new state |
| `registerFCMToken(token)` | Registers push notification token for current shop |
| `hasFeature(feature, {isUserSpecific?})` | Checks shop-level or user-level premium feature flag |

---

## Entities

| Entity | Location | Description |
|---|---|---|
| `UserEntity` | `core/common/entities/` | Shared across features — holds user info, shop list, settings, premium features |
| `UserShopEntity` | `core/common/entities/` | Represents a single shop the user has access to |
| `ShopSettingsEntity` | `core/common/entities/` | Shop-level settings (cooling period, service types, etc.) |

> `UserEntity` lives in `core/` because it is consumed by nearly every feature.

---

## API Endpoints

| Method | Endpoint | Datasource method |
|---|---|---|
| POST | `/api/v3/auth/login/` | `userLogin()` |
| POST | `/api/v3/auth/wallet-login/` | `secretLogin()` |
| POST | `/api/v3/auth/change-password/` | `changeAccountPassword()` |
| POST | `/api/v3/auth/update-secondary-password/` | `changeSecretPassword()` |
| POST | `/api/v1/token/refresh/` | `refreshToken()` |
| GET  | `/api/v4/auth/profile/` | `fetchUserData()` |
| POST | `/api/v3/notifications/device-tokens/register/` | `registerFCMToken()` |
| POST | `/api/v3/notifications/device-tokens/remove/` | `removeFCMToken()` |
| POST | `/api/v3/notifications/device-tokens/update-shop/` | `updateFCMTokenWhenShopSwitching()` |

---

## Dependencies

| Dependency | Source |
|---|---|
| `DioClient.dio` | `lib/utils/network/dio_client/` |
| `SessionStorage` | `lib/core/session/` |
| `TokenRefreshManager` | `lib/core/session/` |
| `SharedPreferenceHelper` | `lib/utils/shared_preference_helper.dart` |
| `UserEntity`, `UserModel` | `lib/core/common/` |

---

## Gotchas

- **`UserCubit` is global** — it is the only BLoC/Cubit in the app provided at the root `MaterialApp` level. Every other feature reads `context.read<UserCubit>()` to get the current user and check feature flags.
- **`clearUserSession()` is called before every login attempt** — ensures stale tokens from a previous session do not interfere.
- **Concurrent token refresh** — `TokenRefreshManager` ensures only one `/token/refresh/` request fires at a time; all other requests queue until the single refresh resolves.
- **FCM token is optional everywhere** — all FCM calls are no-ops if no token is available (e.g., browser context where push is not supported).
