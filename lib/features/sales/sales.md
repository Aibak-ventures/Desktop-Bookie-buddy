# Sales Feature

Manages direct (non-booking) sales transactions — creation, editing, viewing, deletion, and invoice generation.

---

## Responsibilities

- List sales with search and date-range filtering
- View full sale details (products, payment, client, staff)
- Create and edit sales with product selection, pricing, and discount
- Delete sales
- Download sale invoices as PDF or send via WhatsApp

---

## Directory Structure

```
sales/
├── data/
│   ├── datasources/
│   │   └── sales_remote_datasource.dart         # All sales API calls
│   ├── models/
│   │   ├── sale_model/                           # List-view sale (handles staff_color typo in API)
│   │   ├── sale_details_model/                   # Full sale; nested ProductSaleInfoModel
│   │   ├── sales_request_model/                  # Write model; fromEntity() factory
│   │   └── request_sales_model/                  # Alternative write model (legacy — used in booking)
│   └── repositories/
│       └── sales_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── sale_entity/                          # List-view sale
│   │   ├── sale_details_entity/                  # Full sale; nested ProductSaleInfoEntity
│   │   └── sales_request_entity/                 # Write entity; holds ProductSelectedEntity list
│   ├── repositories/
│   │   └── i_sales_repository.dart
│   └── usecases/
│       ├── get_sales_usecase.dart
│       ├── get_sale_details_usecase.dart
│       ├── create_sale_usecase.dart
│       ├── update_sale_usecase.dart
│       ├── delete_sale_usecase.dart
│       ├── get_sale_invoice_pdf_usecase.dart
│       └── send_sale_invoice_usecase.dart
└── presentation/
    ├── bloc/
    │   ├── all_sales_bloc/                       # Paginated sales list
    │   ├── sales_details_bloc/                   # Single sale + delete
    │   ├── save_sales_cubit/                     # Create/update with validation
    │   └── sales_details_drawer_cubit/           # Drawer open/close state
    ├── controllers/
    │   └── add_or_edit_sales_form_state_controller.dart   # Form fields + change detection
    ├── pages/
    │   └── edit_sales_screen.dart                # Create and edit sales form
    └── widgets/                                  # Drawer sections, form sections, product table
```

---

## Key Flows

### View Sales List
```
AllSalesScreen
  → AllSalesBloc.loadSales(page, search?, fromDate?, toDate?)
    → GetSalesUseCase → GET /api/v4/sales/sales/
  → Emits loaded(sales[], nextPageUrl, ...)
```

### Create / Edit Sale
```
EditSalesScreen
  → AddOrEditSalesFormStateController.buildRequest()
    → Compares 12 fields against original sale (edit mode) or builds fresh (create mode)
    → Returns SalesRequestEntity (or null if nothing changed)
  → SaveSalesCubit.saveSales(salesRequest, isEditMode)
    → Validates: products not empty, price > 0, total > 0
    → CreateSaleUseCase  → POST /api/v4/sales/sales/
    → UpdateSaleUseCase  → PATCH /api/v4/sales/sales/update-sale/{id}/
```

### Download / Send Invoice
```
GetSaleInvoicePdfUseCase.call(saleId)   → GET /api/v3/sales/sales/send-invoice/{id}/    # returns bytes
SendSaleInvoiceUseCase.call(saleId, sendWhatsApp: true)
  → GET /api/v3/sales/sales/send-invoice/{id}/?send_whatsapp=true
```

---

## State Management

### `AllSalesBloc`

| Event | Description | Resulting State |
|---|---|---|
| `loadSales` | Initial or filtered load | `loading` → `loaded` or `error` |
| `loadMoreSales` | Scroll pagination (throttled) | `loaded` with `isPaginating: true` → merged `loaded` |

### `SalesDetailsBloc`

| Event | Description | Resulting State |
|---|---|---|
| `fetchSaleDetails` | Load single sale | `loading` → `loaded` or `error` |
| `deleteSale` | Delete sale | `success(didPop: true)` |

### `SaveSalesCubit`

| Method | Description | Resulting State |
|---|---|---|
| `saveSales(request, isEditMode)` | Validate + create or update | `saving` → `success` or `failure` |

Validation performed in cubit before calling use case:
- Products list must not be empty
- Each product price > 0, quantity > 0
- Total amount > 0
- Formats "Insufficient stock" API errors into readable messages

### `SalesDetailsDrawerCubit`

| Method | Description |
|---|---|
| `openDrawer(saleId)` | Opens drawer for given sale ID |
| `closeDrawer()` | Closes drawer |
| `toggleDrawer(saleId?)` | Toggle open/closed |

---

## Entities

| Entity | Key notes |
|---|---|
| `SaleEntity` | List view; `clientPhone` is `dynamic` — can be int or string from API |
| `SaleDetailsEntity` | Full details; nested `ProductSaleInfoEntity` list |
| `SalesRequestEntity` | Holds `List<ProductSelectedEntity>` from product feature |

---

## API Endpoints

| Method | Endpoint | Operation |
|---|---|---|
| GET | `/api/v4/sales/sales/` | Paginated sales list; query: `page`, `search`, `from`, `to` |
| GET | `/api/v4/sales/sales/{id}/` | Get sale details |
| POST | `/api/v4/sales/sales/` | Create sale |
| PATCH | `/api/v4/sales/sales/update-sale/{id}/` | Update sale |
| DELETE | `/api/v4/sales/sales/{id}/` | Delete sale |
| GET | `/api/v3/sales/sales/send-invoice/{id}/` | Download PDF (bytes) |
| GET | `/api/v3/sales/sales/send-invoice/{id}/?send_whatsapp=true` | Send to WhatsApp |

---

## Dependencies

| Dependency | Source |
|---|---|
| `ProductSelectedEntity`, `SelectProductBloc` | `product` feature — product selection in sale form |
| `StaffSearchCubit` | `staff` feature — staff assignment |
| `ClientCubit` | `client` feature — client lookup |
| `DioClient.dio` | `lib/utils/network/` |
| `safeApiCall` | `lib/utils/safe_api_call.dart` |

---

## Gotchas

- **`clientPhone` is `dynamic`** — the API returns it as an integer in some versions and a string in others. `SaleModel` accepts `dynamic` and `SaleEntity` stores it as `dynamic`. Guard against this when displaying.
- **`staff_col lor` typo in API** — `SaleModel.fromJson()` has a custom override to handle a literal typo in the API response key (`staff_col lor` → `staff_color`).
- **Two request models** — `SalesRequestModel` is the canonical model (entity-driven). `RequestSalesModel` is a legacy model used directly in the booking feature's `_buildSalesRequest()`. This is the known violation documented in CLAUDE.md: presentation is constructing the model directly instead of going through an entity.
- **12-field change detection** — `AddOrEditSalesFormStateController.buildRequest()` compares all form fields to the original `SaleDetailsEntity` and returns `null` if nothing changed, preventing unnecessary API calls.
- **Invoice endpoint is v3** — unlike most sales endpoints which are v4, the invoice download/send endpoint is still on v3.
