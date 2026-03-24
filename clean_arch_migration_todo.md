# Clean Architecture Migration — Feature Checklist

> Migrate features in order. Each feature follows the same pattern:
> `data/` → `domain/` → `presentation/` + register in DI.

---

## ✅ Done
- [x] **auth** — login, secret login, change password, session, token refresh
- [x] **splash** — thin, just checks token and routes; no datasource needed
- [x] **client** — only `view/` + `view_model/`; CRUD via existing `ClientRepository` in core.
- [x] **staff** — Complete feature migration to Clean Architecture, including Use Cases, Blocs, Widgets, and DI.
- [x] **dashboard** — Renamed from `home`. Contains `LoadDashboardUseCase`, reads only, has clear domain boundaries.
- [x] **sales** (Groups: `sales`, `sale_details`, `add_or_edit_sales`) — `SalesRepository` existed in core; moved to feature-scoped domain layer.
- [x] **product** (Groups: `product`, `product_details`, `stock_management`, `transfer_product`, `select_product_booking`) — Complex logic around variants, history, and available stock.
- [x] **booking** (Groups: `add_booking`, `add_old_booking`, `edit_booking`, `new_booking`, `all_booking`, `completed_bookings`, `booking_details`, `product_all_booking`) — This is the core engine of the app. It reads and writes, handles payment states, interfaces with clients and products, and dictates schedule availability.

---

## ✅ Core/Common — Entity/Model Separation (Done)
- [x] **UserEntity** / **UserShopEntity** / **ShopSettingsEntity** — created in `core/common/entities/`; `toEntity()` mappers added to all three models; all domain interfaces, use cases, repository impls, and presentation files updated
- [x] **All feature entities** — `ProductEntity`, `BookingEntity`, `ClientEntity`, `SaleEntity`, `StaffEntity`, etc. separated from their JSON models
- [x] `core/repositories/` — fully migrated to feature-scoped domain layers (directory no longer exists)
- [x] `core/services/` — removed; endpoints moved to `core/constants/endpoints/`

---

## 🔧 Phase 4 — Cleanup / Violations

These are pattern violations discovered during audit. Features are migrated but need fixes:

- [ ] **`DocumentFileEntity`** — `DocumentFile` model leaks into domain layer
  - Create `document_file_entity.dart` in `booking/domain/entities/document_file_entity/`
  - Update `IBookingRepository` and `UpdateBookingPartialUseCase` to use entity
  - Convert `DocumentFile` only inside repository impl
  - Update `new_booking_screen.dart` and `edit_new_booking_screen.dart` to use entity

- [ ] **`MeasurementFieldEntity`** — file exists but is broken
  - File is misnamed: `measurement_field_entity/measurement_field_model.dart` → rename to `measurement_field_entity.dart`
  - Remove `import 'package:flutter/material.dart'` and `TextEditingController` field (UI concern, not domain)
  - `MeasurementFieldForm` already exists at `presentation/common/models/measurement_field_form_state.dart` ✅
  - Update all presentation files that imported the old misnamed entity

- [ ] **`AdditionalChargesModel` in presentation** — entity already exists
  - `AdditionalChargesEntity` already exists in `booking/domain/entities/additional_charges_entity/` ✅
  - Replace `AdditionalChargesModel` imports/usage in:
    - `booking_summary_section.dart`
    - `booking_payment_details_section.dart`
    - `add_additional_charge_dialog.dart`
    - `additional_charges_list_widget.dart`

- [ ] **`RequestSalesModel` / `SalesRequestModel` constructed in presentation**
  - `new_booking_screen.dart` constructs `RequestSalesModel` directly
  - `edit_sales_screen.dart` constructs `SalesRequestModel` directly
  - Presentation should build the entity; the use case/repository constructs the request model via `fromEntity()`

---

## 🔵 Phase 5 — Wrap-up

- [ ] Add unit tests for all use cases
- [ ] Consider per-feature DI files (e.g., `booking_dependencies.dart`) as the project grows
