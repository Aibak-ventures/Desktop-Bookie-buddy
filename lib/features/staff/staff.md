# Staff Feature

Manages shop staff records and provides staff selection across booking and sales forms. Also handles monthly performance analytics per staff member.

---

## Responsibilities

- List, add, edit, and delete staff members
- Provide type-ahead staff search for booking/sales form assignment
- Load monthly analytics: booking count, sales count, pending count, and total amounts
- Paginate monthly bookings and sales transactions per staff member

---

## Directory Structure

```
staff/
├── data/
│   ├── datasources/
│   │   └── staff_remote_datasource.dart          # CRUD + analytics + monthly transactions
│   ├── models/
│   │   ├── staff_model/                          # id, name, phone
│   │   ├── staff_details_model/                  # id, name, phone, createdAt
│   │   ├── staff_request_model/                  # Write model; excludes null + id from JSON
│   │   └── staff_analytics_model/                # Monthly performance; snake_case mapping
│   └── repositories/
│       └── staff_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── staff_entity/                         # id, name, phoneNumber
│   │   ├── staff_details_entity/                 # id, name, phoneNumber, createdAt
│   │   ├── staff_request_entity/                 # All optional for add/edit
│   │   └── staff_analytics_entity/               # Monthly stats + performancePercent; empty() factory
│   ├── repositories/
│   │   └── i_staff_repository.dart
│   └── usecases/
│       ├── get_staffs_usecase.dart
│       ├── get_staff_details_usecase.dart
│       ├── add_staff_usecase.dart
│       ├── edit_staff_usecase.dart
│       ├── delete_staff_usecase.dart
│       ├── get_staff_analytics_report_usecase.dart
│       ├── get_staff_monthly_bookings_usecase.dart
│       └── get_staff_monthly_sales_usecase.dart
└── presentation/
    ├── bloc/
    │   └── staff_search_cubit/
    │       ├── staff_search_cubit.dart           # Load all staff; select / clear
    │       └── staff_search_state.dart           # staffs[], selectedStaff?, isLoading
    └── widgets/
        └── staff_search_name_field.dart          # Type-ahead staff selector (TypeAheadField)
```

---

## Key Flows

### Load All Staff (for form assignment)
```
StaffSearchCubit.getAllStaffs([existingStaffId?, existingStaff?])
  → Paginates through all pages of GET /api/v3/shop/staff/
  → Appends results until no nextPageUrl
  → If existingStaffId provided and not in list: inserts existingStaff at top
  → Selects by existingStaffId if provided
  → Emits StaffSearchState(staffs: allStaff, selectedStaff: ...)
```

### Select Staff in Form
```
StaffSearchNameField (TypeAheadField)
  → Filters BlocBuilder state.staffs by name (case-insensitive, client-side)
  → User selects suggestion
    → StaffSearchCubit.selectStaff(entity)
      → Updates nameController text
      → Emits state with selectedStaff
```

### Analytics
```
GetStaffAnalyticsReportUseCase.call(staffId, year, month)
  → GET /api/v3/shop/staff-earnings/earnings-report/{id}/?year=X&month=Y
  → Returns StaffAnalyticsEntity (totalBookingsAmount, totalSalesAmount, performancePercent, ...)

GetStaffMonthlyBookingsUseCase / GetStaffMonthlySalesUseCase
  → POST /api/v3/shop/staff-earnings/monthly-transactions/
  → Body: { staff_id, year, month, page, transaction_type }
```

---

## State Management

### `StaffSearchCubit` — State: `StaffSearchState`

| Method | Description |
|---|---|
| `getAllStaffs([existingStaffId?, existingStaff?])` | Paginate all staff; optionally pre-select |
| `selectStaff(entity)` | Set selectedStaff in state |
| `selectStaffById(id)` | Find in loaded list and select |
| `clearSelectedStaff()` | Reset selectedStaff to null |

`StaffSearchCubit` is provided locally in booking and sales screens (not globally).

---

## Entities

| Entity | Key notes |
|---|---|
| `StaffEntity` | Minimal: id, name, phoneNumber |
| `StaffDetailsEntity` | Adds createdAt |
| `StaffRequestEntity` | All fields optional — used for both POST and PATCH |
| `StaffAnalyticsEntity` | Includes `performancePercent`, `totalAmount`; `empty()` factory for placeholder state |

---

## API Endpoints

| Method | Endpoint | Operation |
|---|---|---|
| GET | `/api/v3/shop/staff/` | Paginated staff list; query: `page` |
| GET | `/api/v3/shop/staff/{id}/` | Get staff details |
| POST | `/api/v3/shop/staff/` | Add staff |
| PATCH | `/api/v3/shop/staff/{id}/` | Edit staff |
| DELETE | `/api/v3/shop/staff/{id}/` | Delete staff |
| GET | `/api/v3/shop/staff-earnings/earnings-report/{id}/` | Monthly analytics; query: `year`, `month` |
| POST | `/api/v3/shop/staff-earnings/monthly-transactions/` | Monthly bookings or sales; body: `{staff_id, year, month, page, transaction_type}` |

---

## Dependencies

| Dependency | Source |
|---|---|
| `BookingModel`, `SaleModel` | `booking` / `sales` — repository returns these for monthly transactions |
| `DioClient.dio` | `lib/utils/network/` |
| `safeApiCall` | `lib/utils/safe_api_call.dart` |
| `AppMainFeatureType` | `lib/core/constants/enums/` — determines `transaction_type` in monthly query |

---

## Gotchas

- **Staff search is client-side** — `StaffSearchNameField` filters the already-loaded `state.staffs` list locally. There is no server-side search for staff by name; `getAllStaffs()` fetches all pages upfront.
- **`StaffRequestModel` excludes null fields and id from JSON** — uses `includeIfNull: false` and `includeToJson: false` on `id`, so the same model works for both POST (no id) and PATCH (id in URL only).
- **Monthly transactions use POST** — the monthly bookings/sales pagination endpoint is a POST despite being a read operation. The `transaction_type` field in the body determines whether to return bookings or sales.
- **`StaffAnalyticsEntity.empty()`** — used as a placeholder state in the analytics screen before data loads. Accepts optional staffId, staffName, and date to pre-populate the header while the API call is in flight.
