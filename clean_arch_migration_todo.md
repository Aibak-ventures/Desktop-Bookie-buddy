# Clean Architecture Migration — Feature Checklist

> Migrate features in order. Each feature follows the same pattern:
> `data/` → `domain/` → `presentation/` + register in DI.

---

## ✅ Done
- [x] **auth** — login, secret login, change password, session, token refresh
- [x] **search** — single query use case, no mutations, already has `services/` + `repositories/`
- [x] **splash** — thin, just checks token and routes; no datasource needed
- [x] **save_expense** (now `expense`) — moved shared data/domain layer to its own feature, combined add global/product expenses.
- [x] **client** — only `view/` + `view_model/`; CRUD via existing `ClientRepository` in core.
- [x] **staff** — Complete feature migration to Clean Architecture, including Use Cases, Blocs, Widgets, and DI.
- [x] **dashboard** — Renamed from `home`. Contains `LoadDashboardUseCase`, reads only, has clear domain boundaries.
- [x] **settings** — Extracted settings endpoints out of `ShopService`/`ShopRepository` into a dedicated Domain/Data layer.
- [x] **profile** — user info, bug report, shop activity; a few use cases but no cross-feature deps.
- [x] **sales** (Groups: `sales`, `sale_details`, `add_or_edit_sales`) — `SalesRepository` existed in core; moved to feature-scoped domain layer.
- [x] **product** (Groups: `product`, `product_details`, `stock_management`, `transfer_product`, `select_product_booking`) — Complex logic around variants, history, and available stock.
- [x] **ledger** — wallet, payments, pending, security amounts; most complex read-heavy data layer, relies heavily on shared Core models.
- [x] **booking** (Groups: `add_booking`, `add_old_booking`, `edit_booking`, `new_booking`, `all_booking`, `completed_bookings`, `booking_details`, `product_all_booking`) — This is the core engine of the app. It reads and writes, handles payment states, interfaces with clients and products, and dictates schedule availability.

---

---

## 🔵 Phase 4 — Remaining Features

These features were not part of the original migration plan but still use old patterns:

- [ ] **all_shop_summary** — MVVM-style (`models/`, `view_models/`, `view/`); uses Cubits but lacks domain layer, datasources, and repositories
- [ ] **select_product_booking** — Mixed BLoC/Cubit nested inside view layer; needs full `data/domain/presentation` split
- [ ] **in_app_update** — Basic `repository/` + `services/` pattern; small (3 files), missing domain layer and usecases
- [ ] **notifications** — 2 standalone service files; consider moving to `core/services` or creating a minimal feature layer

---

## 🔵 Phase 5 — Wrap-up

- [ ] Move remaining `core/repositories/` to feature-scoped domain layers
- [ ] Create per-feature DI files (e.g., `home_dependencies.dart`) as the project grows
- [ ] Add unit tests for all use cases

---

## 🟢 Phase 1 — Easy (Completed ✅)

## 🟡 Phase 2 — Medium (Completed ✅)

## 🔴 Phase 3 — Hard (Completed ✅)