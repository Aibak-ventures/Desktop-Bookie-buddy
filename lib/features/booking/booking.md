# Booking Feature

The largest feature in the app. Manages the full lifecycle of bookings and sales — creation, editing, status tracking, payments, refunds, invoices, and historical records.

---

## Responsibilities

- Create, edit, delete, and cancel bookings and sales
- Track delivery status (pending, returned, cancelled) and payment status (paid, unpaid)
- Accept partial or full payments and issue refunds
- Support document uploads (e.g., vehicle docs) and product customizations (measurements)
- Generate and send PDF invoices via WhatsApp
- Provide a paginated desktop booking list with status-based filtering
- Support "old booking" creation for historical entries

---

## Directory Structure

```
booking/
├── data/
│   ├── datasources/
│   │   └── booking_remote_datasource.dart       # All booking API calls
│   ├── models/
│   │   ├── booking_model/                       # List-view booking (mobile-oriented)
│   │   ├── booking_details_model/               # Full single booking details
│   │   ├── booking_request_model/               # POST/PATCH request payload
│   │   ├── desktop_booking_model/               # Desktop list item + status counts
│   │   ├── booking_details_payment_history_model/
│   │   ├── additional_charges_model/
│   │   ├── booking_other_details_model/         # Vehicle fields (location, etc.)
│   │   ├── measurement_value_model/
│   │   ├── security_summary_model/
│   │   └── document_file_model.dart
│   └── repositories/
│       └── booking_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── booking_entity/                      # Summary/list view
│   │   ├── booking_details_entity/              # Full details with computed getters
│   │   ├── booking_request_entity/              # Write request data
│   │   ├── desktop_booking_item_entity/
│   │   ├── booking_other_details_entity/
│   │   ├── additional_charges_entity/
│   │   ├── booking_payment_history_entity/
│   │   ├── status_counts_entity/
│   │   ├── security_summary_entity/
│   │   ├── measurement_value_entity/
│   │   └── document_file_entity/
│   ├── repositories/
│   │   └── i_booking_repository.dart
│   └── usecases/                                # 17 use cases — one per operation
└── presentation/
    ├── all_booking/
    │   ├── bloc/
    │   │   ├── all_booking_bloc/                # List with pagination + status filters
    │   │   └── booking_details_drawer_cubit/    # Drawer open/close state
    │   ├── pages/
    │   │   └── all_bookings_desktop_screen.dart
    │   └── widgets/                             # Table rows, drawer sections, status dropdowns
    ├── booking_details/
    │   ├── bloc/
    │   │   ├── booking_details_bloc/            # Single booking + all status/payment ops
    │   │   └── booking_details_payment_history_cubit/
    │   └── widgets/                             # Dialogs, buttons, history tiles
    ├── new_booking/
    │   ├── pages/
    │   │   └── new_booking_screen.dart          # Create booking / sale
    │   ├── helpers/                             # Product, validation, text field builders
    │   └── widgets/                             # App bar, customization, document upload
    ├── edit_new_booking/
    │   └── pages/
    │       └── edit_new_booking_screen.dart
    └── common/
        ├── bloc/
        │   └── booking_selection_cubit/         # Multi-select for batch ops
        ├── booking_form/
        │   ├── booking_form_controllers.dart    # All TextEditingControllers + ValueNotifiers
        │   ├── booking_form_mixin.dart          # Shared search, product, date logic
        │   └── booking_type_enum.dart           # booking / sales / oldBooking / customWork
        ├── models/
        │   └── measurement_field_form_state.dart  # UI-only state for measurement inputs
        └── widgets/                             # Reusable panels, product rows, search overlay
```

---

## Key Flows

### Create Booking
```
NewBookingScreen (BookingFormMixin)
  → AddBookingUseCase.call(BookingRequestEntity)
    → BookingRequestModel.fromEntity(entity)
    → POST /api/v5/bookings/bookings/
  → Success → _showSuccessDialog(bookingId)
```

### Create Sale (from New Booking tab)
```
NewBookingScreen
  → CreateSaleBookingUseCase.call(saleData)
    → POST /api/v4/sales/sales/
```

### Edit Booking
```
EditNewBookingScreen (BookingFormMixin)
  → UpdateBookingPartialUseCase.call(bookingId, entity, newDocs?, removedUrls?)
    → PATCH /api/v5/bookings/update-details/{id}/     # with FormData for file uploads
```

### Payment / Status Update
```
BookingDetailsBloc
  → UpdatePaymentUseCase     → POST /api/v5/bookings/bookings/add-payment/{id}/
  → UpdateDeliveryStatusUseCase → PATCH /api/v5/bookings/update-delivery-status/{id}/
  → UpdateBookingStatusUseCase  → PATCH /api/v5/bookings/update-booking-status/{id}/
  → CancelBookingUseCase     → sets status to cancelled + optional refund
  → AddRefundUseCase         → POST /api/v5/bookings/refund/{id}/
```

### Product Search in Booking Form
```
BookingFormMixin.onSearchChanged()
  → SelectProductBloc.searchProducts(query, type, dates)
    → GET /api/v3/bookings/bookings/desktop-available-products/  # for booking type
    → GET /api/v3/service/product-search/                        # for sales type
  → SelectProductBloc emits _Loaded
  → BookingFormMixin._selectProductBlocSubscription listener
    → form.overlayProducts.value = products
    → showSearchOverlay()
```

---

## State Management

### `AllBookingBloc`

| Event | Description | Resulting State |
|---|---|---|
| `LoadBookings` | Initial/filtered list load | `loading` → `loaded` or `error` |
| `LoadNextPageBookings` | Scroll to paginate (throttled) | `loaded` with `isPaginating: true` → merged `loaded` |
| `UpdateBooking` | Sync list item after edit | `loaded` (optimistic update) |
| `UpdateDeliveryStatus` | Change delivery status in list | `loaded` (optimistic update) |
| `DeleteBooking` | Remove from list + reload | `loaded` |
| `MarkAsCompleted` | Set returned + paid statuses | `loaded` |

### `BookingDetailsBloc`

| Event | Description | Resulting State |
|---|---|---|
| `FetchBookingDetails` | Load single booking | `loading` → `loaded` or `error` |
| `UpdateDeliveryStatus` | Change delivery status | `loaded` (updated entity) → `success` |
| `UpdateBookingStatus` | Change payment status | `loaded` (updated entity) → `success` |
| `UpdatePayment` | Add payment entry | `success` |
| `CancelBooking` | Cancel + optional refund | `success(didPop: true)` |
| `DeleteBooking` | Permanently delete | `success(didPop: true, needRefresh: true)` |

### `BookingFormMixin` (shared across New + Edit screens)

Handles: product search, date selection, product add/remove/quantity, price editing, cooling period, service filtering, scroll-based pagination of search results. Both `NewBookingScreen` and `EditNewBookingScreen` use it via mixin.

---

## Entities

| Entity | Key computed getters |
|---|---|
| `BookingDetailsEntity` | Now from `bookie_buddy_shared` (core/) (shared with mobile — see `docs/shared-packages-plan.md` in the mobile repo). `actualPaidAmount`, `remainingSecurityBalance`, `netBalance`, `hasPartialSecurityRefund`, `showSecurityInPayments`, `showSecurityRefundSection` live in `booking_details_entity_web_extensions.dart` (web-local, no mobile equivalent) |
| `BookingRequestEntity` | `hasChanges` — compares to original for partial update detection |
| `StatusCountsEntity` | pending, upcoming, returns, not_returned, completed counts |

---

## API Endpoints

| Method | Endpoint | Operation |
|---|---|---|
| GET | `/api/v5/bookings/bookings/` | Paginated booking list |
| POST | `/api/v5/bookings/bookings/` | Create booking |
| GET | `/api/v5/bookings/bookings/{id}/` | Get single booking |
| PATCH | `/api/v5/bookings/update-details/{id}/` | Update booking (partial or full) |
| DELETE | `/api/v3/bookings/bookings/{id}/` | Delete booking |
| GET | `/api/v5/bookings/bookings/desktop-list/` | Desktop list with status counts |
| PATCH | `/api/v5/bookings/update-booking-status/{id}/` | Update payment status |
| PATCH | `/api/v5/bookings/update-delivery-status/{id}/` | Update delivery status |
| POST | `/api/v5/bookings/bookings/add-payment/{id}/` | Add payment |
| POST | `/api/v5/bookings/refund/{id}/` | Add refund |
| GET | `/api/v3/bookings/bookings/payment-details/{id}/` | Payment history |
| POST | `/api/v5/bookings/bookings/old-bookings/` | Create historical booking |
| GET | `/api/v5/bookings/send-invoice/{id}/` | Download/send invoice PDF |
| GET | `/api/v3/bookings/bookings/desktop-available-products/` | Available products for booking form |

---

## Dependencies

| Dependency | Source |
|---|---|
| `SelectProductBloc` | `product` feature — product search in booking form |
| `ServiceBloc` | `shop` feature — service category filter |
| `StaffSearchCubit` | `staff` feature — staff assignment |
| `ClientCubit` | `client` feature — client search/selection |
| `UserCubit` | `auth` feature — premium feature checks |
| `DioClient.dio` | `lib/utils/network/` |
| `safeApiCall` | `lib/utils/safe_api_call.dart` |

---

## Gotchas

- **File uploads use FormData** — `updateBookingPartial` sends multipart/form-data; nested objects use bracket notation (`other_details[end]`).
- **`BookingFormMixin` stream subscription** — `setupSelectProductBlocListener()` must be called in `initState` and `disposeSelectProductBlocListener()` in `dispose`. Without this, search results do not appear in the overlay even though the API succeeds.
- **Two separate request models** — `BookingRequestModel` (entity-driven, for booking) and a raw `Map` (for sales via `createSale`). These exist for historical reasons.
- **Cooling period** — extends the `returnDate` by N days; affects available product API call dates.
- **`SelectProductBloc` is instantiated per form** — it lives in `BookingFormControllers`, not in the DI container. Each booking form has its own instance.
