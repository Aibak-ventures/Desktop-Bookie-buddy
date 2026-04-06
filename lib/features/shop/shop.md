# Shop Feature

Provides shop and service metadata used across the entire app — available shops for switching, and service categories for product filtering.

---

## Responsibilities

- Fetch the list of shops available to the current user
- Handle shop account switching (persists new shop ID)
- Fetch the list of service categories configured for the current shop
- Provide services to product and booking features for filtering

---

## Directory Structure

```
shop/
├── data/
│   ├── datasources/
│   │   └── shop_remote_datasource.dart     # fetchShops(), fetchServices(), getAllShopSummary()
│   ├── models/
│   │   ├── shop_model/                     # id, name, place, phone, address, subscriptionStatus, image
│   │   └── services_model/                 # id, name, description, icon, mainServiceName
│   └── repositories/
│       └── shop_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── shop_entity/                    # Pure Dart shop record
│   │   └── service_entity/                 # Pure Dart service category record
│   ├── repositories/
│   │   └── i_shop_repository.dart
│   └── usecases/
│       ├── get_shops_usecase.dart
│       └── get_shop_services_usecase.dart
└── presentation/
    └── bloc/
        ├── shop_list_bloc/                 # Load shops + change active shop
        │   ├── shop_list_bloc.dart
        │   ├── shop_list_event.dart
        │   └── shop_list_state.dart
        └── service_bloc/                   # Load + cache service categories
            ├── service_bloc.dart
            ├── service_event.dart
            └── service_state.dart
```

---

## Key Flows

### Load & Switch Shop
```
ShopListBloc.add(loadShops())
  → GetShopsUseCase → GET /api/v3/shop/available-shops/
  → IUserRepository.getShopId()             # reads persisted current shop
  → Emits loaded(shops, currentShopId)

ShopListBloc.add(changeAccount(newShop))
  → IUserRepository.setShopId(newShop.id)   # persists to SharedPreferences
  → Emits changeSuccess(newShop)
  → UserCubit.switchShop(newShop.id)        # called by UI after changeSuccess
```

### Load Services
```
ServiceBloc.add(loadServices())
  → GetShopServicesUseCase → GET /api/v3/service/selected/
  → Emits loaded(services[])

ServiceBloc.add(loadServices(force: false))
  → If already loaded: re-emits current state (no API call)
```

---

## State Management

### `ShopListBloc`

| Event | Description | Resulting State |
|---|---|---|
| `loadShops` | Fetch available shops | `loading` → `loaded(shops, currentShopId)` or `error` |
| `changeAccount(newShop)` | Persist new active shop | `changeSuccess(newShop)` or `error` |

### `ServiceBloc`

| Event | Description | Resulting State |
|---|---|---|
| `loadServices({force: true})` | Fetch service categories | `loading` → `loaded(services[])` or `error` |
| `loadServices({force: false})` | Fetch only if not already loaded | unchanged if `_Loaded`, otherwise fetches |

`ServiceBloc.getServices()` — convenience method; returns services list from `_Loaded` state or `[]`.

---

## Entities

| Entity | Fields |
|---|---|
| `ShopEntity` | id, name, place, phone, email, address, pincode, subscriptionStatus, image |
| `ServiceEntity` | id, name, description, icon, mainServiceName |

---

## API Endpoints

| Method | Endpoint | Operation |
|---|---|---|
| GET | `/api/v3/shop/available-shops/` | List shops available to the user |
| GET | `/api/v3/service/selected/` | List service categories for current shop |
| GET | `/api/v3/shop/all-shop-summary/{year}/{month}/` | Shop summary (used by financial screens) |

---

## Dependencies

| Dependency | Source |
|---|---|
| `IUserRepository` | `auth` feature — `ShopListBloc` uses it to get/set the active shop ID |
| `DioClient.dio` | `lib/utils/network/` |
| `safeApiCall` | `lib/utils/safe_api_call.dart` |

---

## Gotchas

- **`ServiceBloc` is provided globally** — it is registered at the app level because service categories are needed by booking forms, stock management, and product screens simultaneously.
- **`fetchServices()` has custom timeouts** — 30s receive timeout, 15s send timeout, with 3 retries. The services endpoint can be slow on first load.
- **`ShopListBloc` only persists the shop ID** — the actual user data refresh after a shop switch is handled by `UserCubit.switchShop()`, which is called by the UI in response to `changeSuccess`. The two BLoCs are intentionally decoupled.
- **`getAllShopSummary`** is defined in the datasource but not exposed through the repository or use cases. It is called directly from financial/ledger screens.
