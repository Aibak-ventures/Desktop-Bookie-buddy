# CLAUDE.md — Bookie Buddy

> Project context for AI assistants. Keep this up to date as the migration progresses.

---

## What is this project?

**Bookie Buddy** is a Flutter web application for business management — bookings, sales, products, clients, staff, financials, and ledger. Package name: `bookie_buddy_web`.

Flutter version is managed via **fvm** (Flutter Version Manager). The pinned version is in `.fvmrc` / `.fvm/fvm_config.json`. Always use `fvm flutter` instead of `flutter` when running commands.

---

## Current State: Clean Architecture (Complete)

All 9 features are fully migrated to Clean Architecture with entity/model separation. One known violation remains (see Migration Status). All new features must follow the established pattern.

---

## Tech Stack

| Concern | Library |
|---|---|
| Framework | Flutter (via fvm — see `.fvmrc`) |
| State management | `flutter_bloc` — BLoC and Cubit |
| Dependency injection | `get_it` (lazy singletons) |
| Immutable models | `freezed` + `json_serializable` |
| HTTP | `dio` |
| Routing | Flutter `Navigator` (imperative) — `go_router` planned for future |
| Local storage | `shared_preferences`, `flutter_secure_storage` |
| Analytics / Push | Firebase (Crashlytics, Analytics, Messaging) |

---

## Architecture: Clean Architecture Pattern

Every migrated feature has exactly three layers:

```
features/<feature>/
├── data/
│   ├── datasources/         # API calls only — no business logic
│   ├── models/              # JSON-aware Freezed classes; live only in data layer
│   └── repositories/        # Implements domain interface; converts models → entities
├── domain/
│   ├── entities/            # Pure Dart, Freezed, no JSON, no Flutter imports
│   ├── repositories/        # Abstract interface (I<Name>Repository)
│   └── usecases/            # One use case per file, single public call()
└── presentation/
    ├── bloc/ or cubit/      # BLoC/Cubit per screen or logical group
    ├── pages/               # Full-screen Scaffold widgets
    ├── widgets/             # Feature-scoped reusable components
    └── common/
        └── models/          # UI-only state/form classes (e.g., MeasurementFieldFormState)
```

---

## Entity / Model Separation

This is the most important architectural rule. Every data type has two representations:

| Aspect | Entity (`domain/entities/`) | Model (`data/models/`) |
|---|---|---|
| Purpose | Business data used across domain + presentation | JSON serialization for API I/O |
| JSON | ❌ No `.fromJson()`, no `@JsonKey` | ✅ `.fromJson()`, `@JsonKey`, custom converters |
| Business logic | ✅ Computed getters, helpers | ❌ API mapping only |
| Freezed | ✅ `@freezed` | ✅ `@freezed` |
| Flutter imports | ❌ Never | ❌ Never |
| Layer usage | Domain, use cases, repository interfaces, presentation | Data layer only (datasources, repository impl) |
| Conversion | — | `extension XModelMapper { XEntity toEntity() }` |

### Conversion pattern

**Model → Entity (GET):** API JSON → `XModel.fromJson()` → `.toEntity()` → domain/presentation
**Entity → Model (POST/PUT):** Build `XEntity` in presentation → `XModel.fromEntity(entity)` → `.toJson()` → API

```dart
// Model with JSON mapping
@freezed
abstract class SaleModel with _$SaleModel {
  const factory SaleModel({
    required int id,
    @JsonKey(name: 'client_phone') String? clientPhone,
  }) = _SaleModel;

  factory SaleModel.fromJson(Map<String, dynamic> json) =>
      _$SaleModelFromJson(json);
}

extension SaleModelMapper on SaleModel {
  SaleEntity toEntity() => SaleEntity(id: id, clientPhone: clientPhone);
}

// Entity — clean, no JSON concerns
@freezed
abstract class SaleEntity with _$SaleEntity {
  const factory SaleEntity({
    required int id,
    String? clientPhone,
  }) = _SaleEntity;
}
```

### Request model pattern

For write operations, models include a `fromEntity()` factory:

```dart
@freezed
abstract class SalesRequestModel with _$SalesRequestModel {
  @JsonSerializable(includeIfNull: false)
  const factory SalesRequestModel({
    @JsonKey(name: 'staff_id') int? staffId,
    @JsonKey(name: 'client_phone') String? clientPhone,
  }) = _SalesRequestModel;

  factory SalesRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SalesRequestModelFromJson(json);

  factory SalesRequestModel.fromEntity(SalesRequestEntity entity) =>
      SalesRequestModel(staffId: entity.staffId, clientPhone: entity.clientPhone);
}
```

Presentation constructs the **entity**; the repository impl calls `fromEntity()` to build the model before sending to the API.

---

## Layer Rules

- **Datasource** — only Dio calls; no business logic; returns raw models
- **Repository impl** — calls datasource, maps models → entities via `toEntity()`, wraps errors via `safeApiCall`; throws on failure
- **Domain interface** — abstract class; uses entities only; no model types
- **Use case** — `class XUseCase { Future<T> call(...) }`, no state
- **BLoC/Cubit** — calls use cases via `getIt.get()`; works with entities; never touches repository or datasource directly
- **Entities** — `@freezed`, pure Dart; may have computed getters (e.g., `String get fullName`); never contain Flutter imports or UI concerns
- **Presentation models** — classes that hold UI/form state (e.g., `MeasurementFieldFormState`) belong in `presentation/common/models/`, not in `domain/entities/`; they may import Flutter and have `TextEditingController` or similar fields
- **Models** — `@freezed` with `json_serializable`; generated files (`*.freezed.dart`, `*.g.dart`) never edited manually

---

## Naming Conventions

| Thing | Convention | Example |
|---|---|---|
| Files | `snake_case.dart` | `add_booking_bloc.dart` |
| Entity | `PascalCaseEntity` | `BookingEntity` |
| Model | `PascalCaseModel` | `BookingModel` |
| BLoC | `PascalCaseBloc` | `AddBookingBloc` |
| Cubit | `PascalCaseCubit` | `AllShopSummaryCubit` |
| Use case | `PascalCaseUseCase` | `GetBookingUseCase` |
| Datasource | `PascalCaseRemoteDatasource` | `BookingRemoteDatasource` |
| Repo interface | `IPascalCaseRepository` | `IBookingRepository` |
| Repo impl | `PascalCaseRepositoryImpl` | `BookingRepositoryImpl` |
| Screen | `PascalCaseScreen` | `BookingDetailsScreen` |
| Freezed state variants | private prefixed | `_Initial`, `_Loading`, `_Loaded`, `_Error` |

---

## Core Directory

Shared infrastructure in `lib/core/`:

- `di/` — centralized GetIt registration
- `app/` — app-level widgets (e.g., bottom bar, shop switcher)
- `config/` — logger configuration
- `common/entities/` — shared entities: `UserEntity`, `UserShopEntity`, `ShopSettingsEntity`
- `common/models/` — shared models: `UserModel`, `PaginationModel`, API response wrappers
- `common/usecases/` — shared use cases (e.g., `LaunchEmailSupportUseCase`)
- `common/widgets/` — shared UI components
- `constants/enums/` — shared enums (`BookingStatus`, `PaymentMethod`, etc.)
- `constants/endpoints/` — API endpoint constants
- `session/` — token refresh manager, secure action auth, session storage
- `theme/` — colors, typography, app theme (includes `theme/widgets/`)

---

## Utils Directory

Shared utilities in `lib/utils/`:

- `network/dio_client/` — Dio setup (`DioConfig`) and auth interceptor; this is where `DioClient.dio` comes from
- `error/` — typed exceptions per feature (`AuthException`, `BookingException`, etc.) and `Failures`
- `extensions/` — Dart/Flutter extensions (string, date, list, context, widget, etc.)
- `safe_api_call.dart` — wraps datasource calls; used in every repository impl
- `shared_preference_helper.dart` — SharedPreferences wrapper
- `responsive_*.dart` — responsive layout helpers and mixins
- `app_date_utils.dart`, `app_input_validators.dart`, `debouncer.dart` — general-purpose utilities
- `download_file*.dart`, `open_pdf_in_new_tab*.dart`, `share_file.dart` — platform-specific file/PDF helpers (web + stub implementations)

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

Navigation uses Flutter's built-in `Navigator` (imperative push/pop). There is no `go_router` in active use — a few remnants exist in older files but should not be followed.

`go_router` is planned as a future migration; do not introduce it in new code until that migration is underway.

---

## Migration Status

### ✅ Migrated (Clean Architecture + Entity/Model Separation)
`auth`, `booking`, `client`, `dashboard`, `product`, `sales`, `shop`, `splash`, `staff`

### 🔧 Known Violations (Phase 4 — needs cleanup)
- **`SalesRequestModel` constructed in presentation** — screens should build the entity; repository builds the model

When working on a feature, see `booking` or `shop` as the reference implementation.

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
- Feature branches: `<name>/feature/<description>` or `<name>/fix/<description>`
- Commit format: `type(scope): message` (conventional commits)
  - e.g. `refactor(booking): migrate to clean architecture`
  - e.g. `feat(ledger): add export PDF use case`
