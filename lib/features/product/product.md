# Product Feature

Manages the product/inventory catalog. Handles browsing, searching, filtering, adding/editing products with image upload, variant management, stock tracking, and cross-shop product transfer.

---

## Responsibilities

- List, search, and filter products by service, name, category, model, color, price range
- Add and edit products with image upload (FormData, multipart)
- Manage product variants (size, attribute, stock, QR code)
- Display product details: bookings, monthly growth data, variant availability
- Show available products (filtered by date/time) for use in booking forms
- Check variant availability during booking creation/edit
- Transfer product stock between shops

---

## Directory Structure

```
product/
├── data/
│   ├── datasources/
│   │   ├── product_query_remote_datasource.dart    # All read operations (search, fetch, availability)
│   │   └── product_action_remote_datasource.dart   # All write operations (add, update, delete, transfer)
│   ├── models/
│   │   ├── product_model/                          # ProductModel + ProductVariantModel
│   │   ├── product_info_model/                     # Variant-context model for booking use
│   │   ├── product_monthly_expense_model/          # Monthly summary data
│   │   ├── product_selected_model/                 # Selected product with quantity + amount
│   │   └── product_request_model/                  # Write model; toFormJson() for multipart upload
│   └── repositories/
│       └── product_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── product_entity/                         # Full product with variants
│   │   ├── product_variant_entity/                 # id, attribute, stock, remainingStock, QR
│   │   ├── product_info_entity/                    # Variant in booking context
│   │   ├── product_monthly_data_entity/            # Monthly stats
│   │   ├── product_selected_entity/                # variant + amount + quantity + measurements
│   │   └── product_request_entity/                 # Write data including XFile image
│   ├── repositories/
│   │   └── i_product_repository.dart
│   └── usecases/                                   # 14 use cases — one per operation
└── presentation/
    ├── stock_management/
    │   ├── pages/
    │   │   └── stock_management_screen.dart        # Inventory management screen
    │   ├── bloc/
    │   │   ├── product_bloc/                       # Paginated list + search (legacy)
    │   │   ├── stock_management_cubit/             # Main cubit for stock screen
    │   │   └── save_product_cubit/                 # Add/edit product submit
    │   └── widgets/                                # Table rows, dialogs, image picker, variant UI
    ├── product_details/
    │   ├── pages/
    │   │   └── product_details_screen.dart         # Single product view with bookings + growth
    │   ├── bloc/
    │   │   └── product_details_cubit/              # Load product, bookings, growth; variant CRUD
    │   └── widgets/                                # Header, left/right panels, bar chart
    └── common/
        ├── bloc/
        │   ├── select_product_bloc/                # Used by booking + sales forms for product search
        │   ├── product_search_cubit/               # Global product search (type-ahead)
        │   └── selected_products_cubit/            # Multi-select product state (deprecated path)
        └── widgets/                                # Select product dialog, variant tiles
```

---

## Key Flows

### Product Search in Booking Form
```
BookingFormMixin.onSearchChanged()
  → SelectProductBloc.add(searchProducts(query, type, dates, useAvailableProductsApi))
    → useAvailableProductsApi=true (booking):
        GET /api/v3/bookings/bookings/desktop-available-products/
    → useAvailableProductsApi=false (sales/stock):
        GET /api/v3/service/product-search/
  → Emits _Loaded(products, isSearching: true)
  → _selectProductBlocSubscription → form.overlayProducts.value = products
```

### Add / Edit Product (with image)
```
SaveProductCubit.saveProduct(ProductRequestEntity)
  → SaveProductUseCase → IProductRepository.saveProduct()
    → ProductRequestModel.fromEntity(entity)
    → toFormJson() → FormData (multipart image + all fields)
    → POST /api/v3/service/products/            # new
    → PATCH /api/v3/service/products/{id}/      # edit
```

### Vehicle-Specific Attributes
Products with `MainServiceType.vehicle` use bracket-notation fields in FormData:
- `attributes[registration_number]`
- `attributes[pollution_expiry]`
- `attributes[insurance_expiry]`
- `attributes[fitness_expiry]`

---

## State Management

### `StockManagementCubit` (stock screen)

| Method | Description |
|---|---|
| `loadProducts()` | Load with current filters (service, search, price) |
| `loadNextPage()` | Append next page |
| `filterByService(serviceId?)` | Reset filter to service category |
| `searchProducts(query)` | Search within current service |
| `showProductDetails(productId)` | Set selectedProductId in state |
| `deleteProduct(productId)` | Delete then reload |

### `SelectProductBloc` (booking/sales form — one instance per form)

| Event | Description |
|---|---|
| `loadProducts` | Initial product load for the form |
| `loadNextPageProducts` | Scroll pagination (throttled) |
| `searchProducts` | Debounced search with type + price filters |
| `loadNextSearchResults` | Paginate within search results (throttled) |

### `ProductDetailsCubit`

| Method | Description |
|---|---|
| `loadProductDetails(productId, status?)` | Parallel: product info + bookings + growth data |
| `reloadBookingsWithStatus(productId, status?)` | Filter bookings tab |
| `loadMoreBookings(productId, page, status?)` | Paginate bookings |
| `addProductVariant / updateProductVariant / deleteProductVariant` | Variant CRUD then reload |
| `deleteProduct` | Delete product |

---

## Entities

| Entity | Key fields / notes |
|---|---|
| `ProductEntity` | Full product; has computed getters for vehicle attributes (`effectiveRegistrationNumber`, etc.) |
| `ProductVariantEntity` | id, attribute, stock, remainingStock, price, salePrice, externalQrCode |
| `ProductInfoEntity` | Variant in booking context — includes variantId, mainServiceType, measurements |
| `ProductSelectedEntity` | variant (ProductInfoEntity) + amount + quantity + measurements + runningKilometers |
| `ProductRequestEntity` | Includes XFile image — lives in domain; OK because XFile is a cross-platform abstraction |

---

## API Endpoints

| Method | Endpoint | Operation |
|---|---|---|
| GET | `/api/v3/service/product-search/` | Search/filter products (paginated) |
| GET | `/api/v3/service/products/` | List products by service (paginated) |
| GET | `/api/v3/service/products/{id}/` | Get single product |
| POST | `/api/v3/service/products/` | Add product (FormData) |
| PATCH | `/api/v3/service/products/{id}/` | Edit product (FormData) |
| DELETE | `/api/v3/service/products/{id}/` | Delete product or variant |
| GET | `/api/v3/service/products/monthly-summary/{id}/` | Monthly growth data |
| POST | `/api/v3/service/transfer-product/match-product/` | Match product across shops |
| GET | `/api/v3/service/transfer-product/transfer-history/` | Transfer history |
| POST | `/api/v3/service/transfer-product/transfer-stock/` | Transfer stock to another shop |
| GET | `/api/v3/bookings/bookings/desktop-available-products/` | Available products for booking |

---

## Dependencies

| Dependency | Source |
|---|---|
| `BookingEntity`, `SaleModel` | `booking` / `sales` — product details screen shows booking history |
| `ServiceBloc` | `shop` feature — service category for product filtering |
| `UserCubit` | `auth` feature — shop context |
| `DioClient.dio` | `lib/utils/network/` |

---

## Gotchas

- **Dual datasource** — query and action operations are split into two datasource classes (`ProductQueryRemoteDatasource`, `ProductActionRemoteDatasource`). Both are injected into `ProductRepositoryImpl`.
- **`SelectProductBloc` is not in the DI container** — it is instantiated inside `BookingFormControllers` so each booking/sales form has its own instance and lifecycle.
- **Available products API parses differently** — the response nests products under `data.products` instead of the standard `data` key. `ProductRepositoryImpl` handles this custom extraction.
- **BLoC event transformers** — `searchProducts` uses `debounceDroppable()` (waits for typing to stop); `loadNextPageProducts` uses `throttleDroppable()` (prevents rapid scroll triggers).
