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

---

## 🟢 Phase 1 — Easy (Isolated, read-light)

- [ ] **home** (dashboard) — `LoadDashboardUseCase`, reads only, clear boundary.
- [ ] **settings** — mostly navigation + calling auth use cases (already done); thin logic layer.
- [ ] **staff** — `StaffListBloc` already in core; wrap in domain use cases.
- [ ] **profile** — user info, bug report, shop activity; a few use cases but no cross-feature deps.

---

## 🟡 Phase 2 — Medium (Self-contained business hubs)

- [ ] **sales** (Groups: `sales`, `sale_details`, `add_or_edit_sales`) — `SalesRepository` exists in core; move to feature-scoped domain layer.
- [ ] **product** (Groups: `product`, `product_details`, `stock_management`, `transfer_product`, `select_product_booking`) — Complex logic around variants, history, and available stock.
- [ ] **ledger** — wallet, payments, pending, security amounts; most complex read-heavy data layer, relies heavily on shared Core models.

---

## 🔴 Phase 3 — Hard (The Mega-Booking Flow)

> Note: All booking-related folders should be merged into a single `booking` feature.

- [ ] **booking** (Groups: `add_booking`, `add_old_booking`, `edit_booking`, `new_booking`, `all_booking`, `completed_bookings`, `booking_details`, `product_all_booking`) — This is the core engine of the app. It reads and writes, handles payment states, interfaces with clients and products, and dictates schedule availability. 

---

## 🔵 Phase 4 — Wrap-up

- [ ] Move remaining `core/repositories/` to feature-scoped domain layers
- [ ] Create per-feature DI files (e.g., `home_dependencies.dart`) as the project grows
- [ ] Add unit tests for all use cases
