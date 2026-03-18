# CLAUDE.md — Bookie Buddy

> Project context for AI assistants. Keep this up to date as the migration progresses.

---

## What is this project?

**Bookie Buddy** is a Flutter desktop application (Windows/macOS/Linux) for business management — bookings, sales, products, clients, staff, financials, and ledger. Package name: `bookie_buddy_web`, Dart 3.5.1+.

---

## Current State: Mid-Migration to Clean Architecture

The project is **actively being migrated** to Clean Architecture on branch `afnan/refactor/clean-arc`. About 13 of 17 features are done. Do not assume all features follow the same pattern — check the feature folder before working on it.

See [`clean_arch_migration_todo.md`](clean_arch_migration_todo.md) for the full checklist.

---

## Tech Stack

| Concern | Library |
|---|---|
| Framework | Flutter + Dart 3.5.1+ |
| State management | `flutter_bloc` — BLoC and Cubit |
| Dependency injection | `get_it` (lazy singletons) |
| Immutable models | `freezed` + `json_serializable` |
| Functional types | `dartz` — `Either`, `Option` |
| HTTP | `dio` |
| Routing | `go_router` (named routes via enum) |
| Local storage | `shared_preferences`, `flutter_secure_storage` |
| Analytics / Push | Firebase (Crashlytics, Analytics, Messaging) |

---

## Architecture: Clean Architecture Pattern

Every migrated feature has exactly three layers:

```
features/<feature>/
├── data/
│   ├── datasources/         # API calls only — no business logic
│   └── repositories/        # Implements domain interface, wraps errors
├── domain/
│   ├── models/              # Pure Dart, Freezed, no Flutter imports
│   ├── repositories/        # Abstract interface (I<Name>Repository)
│   └── usecases/            # One use case per file, single public call()
└── presentation/
    ├── bloc/ or cubit/      # BLoC/Cubit per screen or logical group
    ├── pages/               # Full-screen Scaffold widgets
    └── widgets/             # Feature-scoped reusable components
```

### Layer rules

- **Datasource** — only Dio calls, converts HTTP errors to typed exceptions
- **Repository impl** — wraps datasource, converts exceptions → `Either<Failure, T>` via `safe_api_call`
- **Domain interface** — abstract class, no concrete types
- **Use case** — `class XUseCase { Future<Either<...>> call(...) }`, no state
- **BLoC/Cubit** — calls use cases via `getIt.get()`, never touches repository or datasource directly
- **Models** — `@freezed` classes with `.fromJson()` / `.toJson()`; generated files (`*.freezed.dart`, `*.g.dart`) are never edited manually

### Naming conventions

| Thing | Convention | Example |
|---|---|---|
| Files | `snake_case.dart` | `add_booking_bloc.dart` |
| BLoC | `PascalCaseBloc` | `AddBookingBloc` |
| Cubit | `PascalCaseCubit` | `AllShopSummaryCubit` |
| Use case | `PascalCaseUseCase` | `GetBookingUseCase` |
| Datasource | `PascalCaseRemoteDatasource` | `BookingRemoteDatasource` |
| Repo interface | `IPascalCaseRepository` | `IBookingRepository` |
| Repo impl | `PascalCaseRepositoryImpl` | `BookingRepositoryImpl` |
| Screen | `PascalCaseScreen` | `BookingDetailsScreen` |
| Model | `PascalCaseModel` | `RequestBookingModel` |
| Freezed state variants | private prefixed | `_Initial`, `_Loading`, `_Loaded`, `_Error` |

---

## Dependency Injection

**Single file:** `lib/core/di/app_dependencies.dart`
**Container:** `GetIt.instance` (global `getIt`)
**Pattern:** lazy singletons, interface-bound where applicable

```dart
static void _registerBookingsFeature() {
  _registerLazy(() => BookingRemoteDatasource(dio: DioClient.dio));
  _registerLazy<IBookingRepository>(() => BookingRepositoryImpl(_get()));
  _registerLazy(() => GetBookingUseCase(_get<IBookingRepository>()));
  _registerLazy(() => AddBookingUseCase(_get<IBookingRepository>()));
  // ...
}
```

When adding a new feature, add a `_register<Feature>Feature()` method and call it from `init()`.

---

## Routing

**Route definitions:** `lib/core/routing/app_routes.dart` — enum with `.path` and `.buildPath()`
**Router config:** `lib/core/routing/app_router.dart` — Go Router with nested routes

```dart
// Navigate to a named route
context.goNamed(AppRoutes.bookingDetails.name,
  pathParameters: {'id': bookingId});
```

Each route wraps its screen in the appropriate `BlocProvider(create: (_) => getIt.get())`.

---

## Core Directory

Shared infrastructure in `lib/core/`:

- `di/` — centralized GetIt registration
- `routing/` — Go Router + route enum
- `network/` — Dio client config
- `models/` — shared models (pagination, API response wrappers)
- `repositories/` — cross-feature repos **not yet migrated** to feature scope (planned in Phase 5)
- `services/` — legacy service layer (ShopService, UserService, ServiceApi)
- `storage/` — SharedPreferences helper, token manager
- `session/` — session state
- `theme/` — colors, typography, app theme
- `ui/` — shared screens and widgets
- `view_model/` — shared BLoC/Cubit (user, shop list, service/category, booking selection)
- `constants/enums/` — shared enums (BookingStatus, PaymentMethod, etc.)

---

## Migration Status

### ✅ Migrated (Clean Architecture)
`auth`, `booking`, `client`, `dashboard`, `expense`, `ledger`, `product`, `profile`, `sales`, `search`, `settings`, `splash`, `staff`

### ⏳ Not Yet Migrated
| Feature | Current Pattern | Notes |
|---|---|---|
| `all_shop_summary` | `models/` + `view_models/` + `view/` | Cubit calls `ShopRepository` from core directly |
| `select_product_booking` | Mixed BLoC/Cubit inside `view/` | No data or domain layers |
| `in_app_update` | `repository/` + `services/` + `view/` | 3 files, no domain layer |
| `notifications` | 2 standalone service files | Candidate for `core/services` or minimal feature |

When working on an unmigrated feature, migrate it to the standard pattern before adding new logic. See a migrated feature (e.g., `ledger` or `booking`) as the reference.

---

## Code Generation

Run after modifying any `@freezed` or `@JsonSerializable` class:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Never manually edit `*.freezed.dart` or `*.g.dart` files.

---

## Branch Strategy

- `main` — production
- `afnan/refactor/clean-arc` — active migration branch
- Feature branches: `<name>/feature/<description>` or `<name>/fix/<description>`
- Commit format: `type(scope): message` (conventional commits)
  - e.g. `refactor(booking): migrate to clean architecture`
  - e.g. `feat(ledger): add export PDF use case`
