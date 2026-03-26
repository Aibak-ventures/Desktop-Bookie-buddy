# Client Feature

Manages customer records used across bookings and sales. Provides search-as-you-type selection and CRUD operations.

---

## Responsibilities

- Search clients by name or phone number with pagination
- Select an existing client to auto-fill contact fields in booking/sales forms
- Add, update, and delete client records
- Handle the case where a new client already exists (return existing record instead of failing)

---

## Directory Structure

```
client/
├── data/
│   ├── datasources/
│   │   └── client_remote_datasource.dart    # GET/POST/PATCH/DELETE client API calls
│   ├── models/
│   │   ├── client_model/                    # Read model — phone1, phone2, E.164 fields
│   │   └── client_request_model/            # Write model — fromEntity() + toCustomJson()
│   └── repositories/
│       └── client_repository_impl.dart      # Maps models → entities; handles "already exists" error
├── domain/
│   ├── entities/
│   │   ├── client_entity/                   # id, name, phone1, phone2, E.164 variants
│   │   └── client_request_entity/           # id?, name?, phone1?, phone2? (all optional)
│   ├── repositories/
│   │   └── i_client_repository.dart
│   └── usecases/
│       ├── get_clients_usecase.dart
│       ├── add_client_usecase.dart
│       ├── update_client_usecase.dart
│       └── delete_client_usecase.dart
└── presentation/
    ├── bloc/
    │   └── client_cubit/
    │       ├── client_cubit.dart            # Search, select, clear client state
    │       └── client_state.dart            # suggestions, selectedClient, searchQuery, isLoading
    └── widgets/
        ├── client_search_name_field.dart    # Type-ahead search input (flutter_typeahead)
        └── client_select_widget.dart        # Full client panel: search toggle + phone fields
```

---

## Key Flows

### Search & Select Client (Booking/Sales Form)
```
ClientSelectWidget
  → ClientSearchNameField (type-ahead, 200ms debounce)
    → ClientCubit.searchClient(query)
      → GetClientsUseCase.call(searchName: query)
        → GET /api/v3/bookings/clients/?name={query}
      → emits state with suggestions list
  → User selects suggestion
    → ClientCubit.selectClient(entity)
      → emits selectedClient; auto-fills phone fields in form
```

### Add Client (from form when client not found)
```
AddClientUseCase.call(ClientRequestEntity, allowExisting: true)
  → POST /api/v3/bookings/clients/
  → If validation error (client already exists) AND allowExisting: true
    → returns existing ClientEntity from error response body
```

---

## State Management

### `ClientCubit` — State: `ClientState`

| Method | Description |
|---|---|
| `searchClient(query)` | Calls use case, updates `suggestions` in state |
| `selectClient(entity)` | Sets `selectedClient`, clears suggestions, fills search field |
| `clearSelected([callback?])` | Resets selection and suggestions; optional delayed callback |
| `getSelectedClient()` | Returns current selected client (internal state) |

`ClientCubit` is provided locally wherever client search is needed (booking form, sales form).

---

## Entities

| Entity | Fields | Notes |
|---|---|---|
| `ClientEntity` | id, name, phone1, phone2, phone1E164, phone2E164 | Read entity — phone in both raw and E.164 format |
| `ClientRequestEntity` | id?, name?, phone1?, phone2? | Write entity — all fields optional for partial updates |

---

## API Endpoints

| Method | Endpoint | Operation |
|---|---|---|
| GET | `/api/v3/bookings/clients/` | Paginated list; query params: `page`, `name`, `phone` |
| POST | `/api/v3/bookings/clients/` | Add new client |
| PATCH | `/api/v3/bookings/clients/{id}/` | Update client |
| DELETE | `/api/v3/bookings/clients/{id}/` | Delete client |

---

## Dependencies

| Dependency | Source |
|---|---|
| `DioClient.dio` | `lib/utils/network/` |
| `safeApiCall` | `lib/utils/safe_api_call.dart` |
| `PaginationModel` | `lib/core/common/models/` |

---

## Gotchas

- **"Already exists" handling** — `addClient()` with `allowExisting: true` gracefully returns the existing client when the API returns a validation error instead of throwing. This is intentional — booking forms use it to avoid duplicate creation.
- **Phone field format** — the API stores and returns phone numbers in both raw integer format (`phone_1`) and E.164 string format (`phone_1_e164`). `ClientModel` reads both.
- **`toCustomJson()`** — the write request uses alternate field names (`client_name`, `client_phone_1`) instead of the standard names used in read responses. This is an API inconsistency handled in the model extension.
- **No dedicated screen** — this feature has no standalone page. It exists purely as a search/selection component embedded in booking and sales forms.
