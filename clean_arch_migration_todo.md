# Clean Architecture Migration — Feature Checklist

> Migrate features in order. Each feature follows the same pattern:
> `data/` → `domain/` → `presentation/` + register in DI.

---

## ✅ Done
- [x] **auth** — login, secret login, change password, session, token refresh

---

## 🟢 Phase 1 — Easy (Isolated, read-light)

- [ ] **search** — single query use case, no mutations, already has `services/` + `repositories/`
- [ ] **splash** — thin, just checks token and routes; no datasource needed
- [ ] **save_expense** — only has `view/` + `view_model/`, no existing repo layer; straightforward write

---

## 🟡 Phase 2 — Medium (Self-contained, some complexity)

- [ ] **home** (dashboard) — `LoadDashboardUseCase`, reads only, clear boundary
- [ ] **profile** — user info, bug report, shop activity; a few use cases but no cross-feature deps
- [ ] **client** — only `view/` + `view_model/`; CRUD via existing `ClientRepository` in core
- [ ] **settings** — mostly navigation + calling auth use cases (already done); thin logic layer
- [ ] **staff** — `StaffListBloc` already in core; wrap in domain use cases

---

## 🟠 Phase 3 — Medium-Hard (Core business features)

- [ ] **sales** — [SalesRepository](file:///Users/afnanp/Desktop/Work/Desktop-Bookie-buddy/lib/core/repositories/sales_repository.dart#11-121) exists in core; move to feature-scoped domain layer
- [ ] **sale_details** — child of sales; shares [SalesRepository](file:///Users/afnanp/Desktop/Work/Desktop-Bookie-buddy/lib/core/repositories/sales_repository.dart#11-121)
- [ ] **completed_bookings** — uses [BookingRepository](file:///Users/afnanp/Desktop/Work/Desktop-Bookie-buddy/lib/core/repositories/booking_repository.dart#20-495); read-only but linked to bookings
- [ ] **product** — complex: product grid, info, growth, add/edit; multiple use cases
- [ ] **stock_management** — delegates to product; migrate after product

---

## 🔴 Phase 4 — Hard (Core booking flow, many interdependencies)

- [ ] **booking_details** — reads + writes, has payment history cubit, linked to all_booking
- [ ] **all_booking** — multiple BLoCs (upcoming, past, sales); high usage across app
- [ ] **add_booking** — multi-step flow; client, product, service, payment — most complex feature
- [ ] **add_old_booking** — extends add_booking pattern
- [ ] **edit_booking** — shares booking domain; depends on booking_details
- [ ] **new_booking** — new desktop flow; depends on product + booking
- [ ] **ledger** — wallet, payments, pending, security amounts; most complex data layer

---

## 🔵 Phase 5 — Wrap-up

- [ ] Move remaining `core/repositories/` to feature-scoped domain layers
- [ ] Create per-feature DI files (e.g., `home_dependencies.dart`) as the project grows
- [ ] Add unit tests for all use cases
