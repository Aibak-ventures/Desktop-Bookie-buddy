# Clean Architecture Migration — Feature Checklist

> Migration is complete. This file tracks remaining cleanup violations and wrap-up tasks.

---

## ✅ Done
- [x] **auth** — login, secret login, change password, session, token refresh
- [x] **splash** — thin, just checks token and routes; no datasource needed
- [x] **client** — CRUD with feature-scoped domain layer
- [x] **staff** — use cases, blocs, widgets, and DI
- [x] **dashboard** — `GetDashboardUseCase`, reads only, clear domain boundaries
- [x] **sales** (groups: `sales`, `sale_details`, `add_or_edit_sales`) — feature-scoped domain layer
- [x] **product** (groups: `product`, `product_details`, `stock_management`, `transfer_product`) — variants, history, available stock
- [x] **booking** (groups: `add_booking`, `add_old_booking`, `edit_booking`, `new_booking`, `all_booking`, `booking_details`) — core engine; payments, clients, products, scheduling
- [x] **shop** — shop list and service/category blocs; feature-scoped domain layer

---

## ✅ Core/Common — Entity/Model Separation (Done)
- [x] **UserEntity** / **UserShopEntity** / **ShopSettingsEntity** — in `core/common/entities/`; `toEntity()` mappers on all models
- [x] **All feature entities** — `ProductEntity`, `BookingEntity`, `ClientEntity`, `SaleEntity`, `StaffEntity`, `ShopEntity`, etc. separated from JSON models
- [x] `core/repositories/` — removed; all repositories are feature-scoped
- [x] `core/services/` — removed; endpoints moved to `core/constants/endpoints/`
- [x] **`DocumentFileEntity`** — fixed; entity created and used throughout domain layer
- [x] **`MeasurementFieldEntity`** — fixed; renamed to `MeasurementFieldFormState`, moved to `booking/presentation/common/models/`
- [x] **`AdditionalChargesModel` in presentation** — fixed; presentation now uses `AdditionalChargesEntity`

---

## 🔧 Phase 4 — Remaining Violations

- [ ] **`SalesRequestModel` constructed in presentation**
  - `new_booking_screen.dart` constructs `RequestSalesModel` directly
  - `edit_sales_screen.dart` constructs `SalesRequestModel` directly
  - Presentation should build the entity; the repository constructs the request model via `fromEntity()`

---

## 🔵 Phase 5 — Wrap-up

- [ ] Add unit tests for all use cases
- [ ] Consider per-feature DI files (e.g., `booking_dependencies.dart`) as the project grows
