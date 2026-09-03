# Printer feature — architecture & flow

This explains **how** printing works in this app, deliberately staying
above the platform-specific data layer (QZ Tray/JS on web) — the point is
the *pattern*, not the transport, so the same design can be ported to a
mobile Flutter project using a completely different printer connector
(Bluetooth/USB via `unified_esc_pos_printer` or similar) underneath.

**Short answer to "is it OK to do the same on mobile":** yes — this is
already *how it started*. Nearly every doc comment in this feature says
some version of "mirrors the mobile app's `ThermalPrinterX`" — this web
implementation was built by porting an existing mobile pattern, not the
other way around. So replicating it back (specifically: adding the
quick-print-without-a-screen path, if mobile doesn't have it yet) is
completing the loop, not introducing something new and unproven.

---

## The two ways to print

This is the core idea worth porting, and the part your question is really
about.

### 1. Quick print (the common case — no screen navigation)

Tapping "Print" on a booking/sale detail screen should just print. The
user picked a default printer once; every print after that should be one
tap, one loading spinner, done — never "go pick a printer" again.

```text
User taps Print
   → printReceiptQuickly(context, ticket)
       → shows a loading overlay
       → QuickPrintReceiptUseCase(ticket)
           → reads the saved default printer name (SharedPreferences)
           → if none saved yet → QuickPrintNoPrinterConfigured
           → else: repository.print(savedPrinterName, ticket)
               → QuickPrintSuccess, or QuickPrintFailed(message)
       → hides the loading overlay
   → on success: done, nothing else shown
   → on "no printer configured" or failure: a small dialog offers
     "Set up printer" → opens the full picker screen, ticket in hand,
     so the *same* print attempt completes from there once a printer's
     chosen
```

**Key design point:** [`QuickPrintReceiptUseCase`](../lib/features/printer/domain/usecases/quick_print_receipt_usecase.dart)
deliberately does **not** check "is the printer bridge/connection
available" first — that would just be a second round trip before the
print attempt itself, which already fails informatively on its own if
the printer isn't reachable. Don't add a pre-flight check here; let the
print attempt be the check.

### 2. The picker/setup screen (the rare case)

A full screen listing available printers, with Connect/Disconnect actions
and a "Save as default" action, only needed for:

- the very first time a shop sets up a printer,
- deliberately switching to a different printer later (Settings),
- as the **fallback** when quick print fails or nothing's configured yet
  (opened automatically, with the already-built ticket handed along, so
  the user doesn't have to redo anything once they pick a printer).

It is **not** shown on every print — that's the whole point of having
path 1. See [`QzPrintScreen`](../lib/features/printer/presentation/print/pages/qz_print_screen.dart)
for the concrete implementation (mobile's equivalent: `ThermalPrintScreen`).

### The "default printer" preference

Just a persisted string (`SharedPreferences`) — the last-used/explicitly-
saved printer's name/identifier. Three operations, each its own tiny use
case (`SaveLastPrinterUseCase`, `GetLastPrinterUseCase`,
`ClearLastPrinterUseCase`), all just thin wrappers around the repository.
Nothing fancier is needed — no "list of favorites," no per-shop
multi-printer profile. One saved default is enough because quick-print's
whole job is "don't make the user choose again."

---

## Layer-by-layer (Clean Architecture, matches this project's `CLAUDE.md`)

```text
domain/
├── entities/
│   ├── print_ticket_entity.dart        → the print job: ordered commands + paper size
│   ├── printer_device_entity.dart      → one listed printer: name (+ live status, web-only addition)
│   └── quick_print_result.dart         → sealed outcome type for the quick-print path
├── repositories/
│   └── i_printer_repository.dart       → the ONE interface the whole feature depends on
├── usecases/                           → one file each, single call(), no state:
│   ├── check_print_bridge_available_usecase.dart
│   ├── connect_print_bridge_usecase.dart
│   ├── find_printers_usecase.dart
│   ├── refresh_printer_statuses_usecase.dart   (web-only — see caveat below)
│   ├── print_receipt_usecase.dart
│   ├── quick_print_receipt_usecase.dart        → the fast path
│   ├── save_last_printer_usecase.dart
│   ├── get_last_printer_usecase.dart
│   └── clear_last_printer_usecase.dart
└── print_ticket_builder.dart           → low-level "add an image/feed/cut" accumulator

presentation/
├── receipt_design/
│   ├── receipt_canvas.dart             → high-level "design a receipt" API: .text()/.row()/
│   │                                      .divider()/.numberedList()/.image(), backed by
│   │                                      PrintTicketBuilder — turns Flutter widgets into
│   │                                      rendered images via off-screen rendering
│   ├── offscreen_render.dart           → the actual widget→image capture mechanism
│   └── monochrome.dart                 → thresholds a rendered image to pure black/white
├── print/
│   ├── quick_print_receipt.dart        → printReceiptQuickly() — the UI-facing entry point
│   ├── print_receipt_with_overlay.dart → shared "read shop, build ticket, show overlay" glue
│   ├── bloc/qz_printer_cubit/          → screen-scoped state for the picker screen ONLY
│   └── pages/qz_print_screen.dart      → the picker/setup screen
└── (per-feature builder, e.g. booking_receipt_canvas_builder.dart)
    → the ONLY place that knows what a booking receipt actually contains;
      everything above is generic "print stuff", this is "what to print"

data/                                    ← THE PART THAT'S PLATFORM-SPECIFIC, SKIP FOR MOBILE
├── datasources/  (QZ Tray JS interop — web only)
├── models/       (JSON-shaped mirrors of the entities, data-layer only)
└── repositories/ (implements i_printer_repository.dart, converts models ↔ entities)
```

**What's genuinely platform-specific (only this needs a mobile-native
rewrite):**

- `data/datasources/` — on web this is QZ Tray's JS client; on mobile
  it'd be whatever Bluetooth/USB/network printer SDK you're using
  (`unified_esc_pos_printer` per this feature's own doc comments,
  implying that's what mobile already uses).
- `data/repositories/qz_printer_repository_impl.dart` — the ESC/POS byte
  generation itself (`esc_pos_utils_plus`) is *not* web-specific and
  could be shared as-is; only the "how do I actually hand these bytes to
  a printer" part (QZ Tray's WebSocket vs. a Bluetooth/USB
  connection) differs.

**Everything else — every file listed above outside `data/` — is pure
Dart/Flutter with no web-only APIs**, and is the part worth porting
directly: entities, repository *interface*, use cases, the
quick-print orchestration, `ReceiptCanvas`'s widget-to-image rendering
approach, and the picker screen's UX shape.

---

## Dependency injection (how it's wired together)

One file per feature, `PrinterDependencies.register()`, called once at
app startup from `app_dependencies.dart`. Registers the datasource, binds
the repository interface to its concrete impl, registers every use case as
a lazy singleton, and registers `QzPrinterCubit` as a **factory** (not
singleton) since the picker screen is the only thing that needs it and
each screen visit should get a fresh instance — no persistent
per-device connection to keep alive across screens/navigations.

A `_useMockPrinterRepository` flag swaps in a fake in-memory repository
(`MockQzPrinterRepositoryImpl`) for local dev without needing the real
bridge/hardware — worth having the mobile equivalent too, since it makes
UI work testable without a physical printer on hand.

---

## Applying this to mobile

If mobile already has a picker screen (`ThermalPrintScreen`, per this
feature's doc comments) but *always* shows it on every print tap, the
gap to close is specifically the **quick-print path**:

1. Add the equivalent of `QuickPrintReceiptUseCase` — reads the saved
   default device identifier, prints straight to it, no pre-flight
   check, returns a sealed result type distinguishing success / not-
   configured / failed.
2. Add `printReceiptQuickly()`'s shape: loading overlay, call the use
   case, on failure/not-configured show a small dialog offering to open
   the full picker screen **with the already-built ticket**, so picking a
   device there completes the same print rather than starting over.
3. Wire every "Print" button (booking details, etc.) to call the quick
   version first, not navigate to the picker screen directly. The picker
   screen becomes reachable only from Settings (deliberate device change)
   and as the automatic fallback from step 2.
4. Reuse the "default device" persistence pattern as-is (three tiny use
   cases wrapping `SharedPreferences`/secure storage) — no new design
   needed there, it's identical regardless of transport.

Nothing about steps 1–4 depends on QZ Tray or any web API — it's the same
shape this project already uses, just pointed at whatever printer
connector mobile already has behind its repository implementation.
