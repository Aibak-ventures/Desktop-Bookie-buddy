# Dashboard Feature

The home screen of the app. Shows upcoming pickups, pending returns, and summary counts — refreshed per shop and navigable to the bookings list.

---

## Responsibilities

- Display upcoming bookings (grouped by today / tomorrow / upcoming)
- Display ongoing/return bookings (grouped by expected return date)
- Show overview count cards: upcoming, alterations, completed, expired
- Support pagination for large booking lists
- Reload automatically when the active shop changes or a booking is updated elsewhere

---

## Directory Structure

```
dashboard/
├── data/
│   ├── datasources/
│   │   └── dashboard_remote_datasource.dart    # Fetches desktop dashboard data
│   ├── models/
│   │   ├── desktop_dashboard_response/         # Main response + carousel + pagination models
│   │   └── dashboard_custom_work_model/        # (defined, currently unused)
│   └── repositories/
│       └── dashboard_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── desktop_dashboard_entity/           # upcoming[], ongoingBookings[], carouselData, pagination
│   │   ├── desktop_dashboard_carousel_entity/  # upcomingCount, completedCount, expiredCount, alterationCount
│   │   └── dashboard_custom_work_entity/       # (defined, currently unused)
│   ├── repositories/
│   │   └── i_dashboard_repository.dart
│   └── usecases/
│       └── get_dashboard_desktop_data_usecase.dart
└── presentation/
    ├── bloc/
    │   └── dashboard_bloc/
    │       ├── dashboard_bloc.dart             # Load, paginate, update, group by date
    │       ├── dashboard_event.dart
    │       └── dashboard_state.dart
    ├── pages/
    │   └── dashboard_screen.dart               # Root screen; integrates with booking BLoCs
    └── widgets/
        ├── dashboard_header.dart               # Greeting + refresh button
        ├── carousel_dashboard.dart             # 3 count cards with navigation
        ├── dashboard_card.dart                 # Generic white card container
        └── dashboard_bookings_columns.dart     # Two-column upcoming/returns view
```

---

## Key Flows

### Initial Load
```
DashboardScreen.initState
  → DashboardBloc.add(loadDashboardData())
    → GetDashboardDesktopDataUseCase.call(page: 1)
      → GET /api/v4/bookings/desktop-dashboard/?page=1
    → Groups bookings: today / tomorrow / upcoming (by pickupDate or returnDate)
    → Emits loaded(upcomingGrouped, returnsGrouped, carouselData, ...)
```

### Shop Switch
```
DashboardScreen BlocListener<UserCubit>
  → DashboardBloc.add(loadDashboardData(activeShop: newShop))
    → Datasource adds header: X-Active-Shop-ID: {shopId}
    → Full reload for new shop context
```

### Booking Updated Elsewhere
```
DashboardScreen initState — listens to AllBookingBloc
  → AllBookingBloc emits Loaded(...)
    → DashboardBloc.add(updateData(booking, shouldRefresh: false))
      → Updates booking in-place in grouped maps (no API call)
```

### Open Booking Details from Dashboard
```
BookingCard.onTap
  → BookingDetailsDrawerCubit.openDrawer(bookingId)
    → DashboardScreen shows BookingDetailsDrawer overlay
```

---

## State Management

### `DashboardBloc`

| Event | Description | Resulting State |
|---|---|---|
| `loadDashboardData` | Full reload, optionally for a specific shop | `loading` → `loaded` or `error` |
| `loadDashboardNextPageData` | Load next page and merge into grouped maps | `loaded` with `isPaginating: true` → merged `loaded` |
| `updateData` | Update or delete a single booking in state | `loaded` (no API call) |
| `loadIfNot` | Lazy load — skips if already loaded | unchanged or `loaded` |

`DashboardState.loaded` fields:

| Field | Type | Description |
|---|---|---|
| `upcomingGrouped` | `Map<String, List<BookingEntity>>` | Keys: `'today'`, `'tomorrow'`, `'upcoming'` |
| `returnsGrouped` | `Map<String, List<BookingEntity>>` | Keys: `'today'`, `'tomorrow'`, `'upcoming'` |
| `carouselData` | `DesktopDashboardCarouselEntity` | Count cards |
| `nextPageUrl` | `String?` | URL for next page |
| `isPaginating` | `bool` | Scroll pagination in progress |

---

## Entities

| Entity | Fields |
|---|---|
| `DesktopDashboardEntity` | upcoming[], ongoingBookings[], carouselData, nextPageUrl, currentPage, totalPages |
| `DesktopDashboardCarouselEntity` | upcomingCount, alterationBookingCount, completedCount, expiredCount |

> Bookings in the dashboard are typed as `BookingEntity` from the `booking` feature.

---

## API Endpoints

| Method | Endpoint | Operation |
|---|---|---|
| GET | `/api/v4/bookings/desktop-dashboard/` | Fetch upcoming + ongoing bookings + counts |

**Query params:** `page` (int, default 1)
**Header:** `X-Active-Shop-ID` (optional, sent when viewing a specific shop)

---

## Dependencies

| Dependency | Source |
|---|---|
| `BookingEntity`, `BookingModel` | `booking` feature |
| `UserCubit` | `auth` feature — active shop context |
| `AllBookingBloc` | `booking` feature — sync on booking changes |
| `BookingDetailsDrawerCubit` | `booking` feature — open drawer from dashboard |
| `DioClient.dio` | `lib/utils/network/` |

---

## Gotchas

- **Grouping is done in the BLoC, not the model** — `_groupData()` in `DashboardBloc` converts flat lists to `Map<String, List<BookingEntity>>` using today/tomorrow/upcoming logic.
- **`DashboardCustomWorkEntity` is unused** — defined and mapped but not rendered anywhere in the current UI. Reserved for a future custom work tab.
- **Legacy endpoint** — `fetchDashboardData()` in the datasource targets the old `/api/v4/bookings/dashboard/` endpoint and is deprecated. Only `fetchDesktopDashboardData()` is used.
- **`reset()` on BLoC** — called by the shop switcher to clear carousel state before reloading; prevents stale count flicker.
