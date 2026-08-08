# Thermal Receipt Printing for the Web App — QZ Tray Bridge Implementation Plan

> **Status: implemented.** The `lib/features/printer/` feature described
> below has been built in this repo (`Desktop-Bookie-buddy`, package
> `bookie_buddy_web`) following this plan, with the amendments in
> "Amendments made during implementation" below. The original plan draft
> referred to "the separate web-app Flutter project" as if this repo had no
> code to change — that no longer applies; `Desktop-Bookie-buddy` *is* that
> web app. The reference pattern mirrored throughout (mobile's
> `lib/features/thermal_printer/`) lives in the sibling `Bookie-Buddy` repo,
> not here.

## Amendments made during implementation

1. **Added a `PrintTicketEntity`/`PrintTicketBuilder` layer (domain) —
   not in the original plan.** The original Step 3/4 had presentation
   build `esc_pos_utils_plus` bytes directly into `PrintJobEntity`,
   skipping the command-accumulator abstraction mobile's
   `thermal_printer` feature uses (`PrintTicketEntity` +
   `PrintTicketCommand` variants `image`/`feed`/`cut`, built via
   `PrintTicketBuilder`). Implemented instead: `domain/entities/
   print_ticket_entity/print_ticket_entity.dart` +
   `domain/print_ticket_builder.dart`, mirrored from mobile almost
   verbatim. `QzPrinterRepositoryImpl` is now the *only* place that turns
   commands into actual ESC/POS bytes (via `esc_pos_utils_plus`) —
   domain/presentation never see that library's types, matching how the
   mobile repository is the only place touching `unified_esc_pos_printer`.
2. **Added last-used-printer persistence** — `IPrinterRepository` gained
   `saveLastPrinter`/`getLastPrinter`/`clearLastPrinter` (plain
   `SharedPreferenceHelper`, not secure storage — a printer name isn't
   sensitive). `QzPrinterCubit.initialize()` preselects the last-used
   printer if it's still in the current `findPrinters()` list. Mirrors
   mobile's `saveLastConnectedDevice`/`getLastConnectedDevice`/
   `clearLastConnectedDevice`, which the original plan's
   `IPrinterRepository` omitted.
3. **Vendored file list corrected**: only `web/qz/qz-tray.js` (v2.2.6, via
   `npm pack qz-tray@2.2.6`) is self-hosted — `rsvp.min.js` and
   `sha-256.min.js` are **not** needed. Confirmed by reading the vendored
   source: v2.2.6 falls back to native `Promise` when no global `RSVP` is
   present (`typeof RSVP !== 'undefined'`), bundles its own SHA-256
   implementation, and only looks for a global `Sha256` for the signed/
   certificate flow — which is deferred per this plan's own decision. If
   the signing certificate is added later, revisit this.
4. **Confirmed `qz.print()`'s raw payload shape** (open item #1) by
   reading `qz-tray.js` v2.2.6's JSDoc directly: `{type: 'raw', format:
   'command', flavor: 'base64', data: <string>}`. `flavor: 'base64'` was
   chosen over `plain`/`hex` since payloads include raw raster image bytes,
   not printable/hex-safe text.
5. **Confirmed `esc_pos_utils_plus` v2.0.4's image API** (open item #2) by
   reading its source: `Generator.imageRaster(image.Image, {align,
   highDensityHorizontal, highDensityVertical, imageFn})` returns
   `List<int>` bytes, taking an `image` package `Image` — same shape mobile
   already uses via `img.Image.fromBytes(...)`. `Generator` itself needs a
   `PaperSize` + `CapabilityProfile.load()` (async, loads a bundled JSON
   asset via `rootBundle` — confirmed web-safe, no native code).
6. **`cut()` has no `linesBefore` param** in `esc_pos_utils_plus` (unlike
   mobile's `unified_esc_pos_printer`) — `QzPrinterRepositoryImpl` feeds
   the clearance explicitly (`generator.feed(command.linesBefore)`) right
   before calling `generator.cut()`.
7. **`QzPrinterCubit` is registered as a GetIt factory, not a lazy
   singleton** — each `QzPrintScreen` needs its own instance since there's
   no cross-screen state worth sharing (see plan's own note that this
   cubit doesn't need mobile's app-wide singleton treatment).

---

## Context

The mobile app (`Bookie-Buddy`) prints receipts via `unified_esc_pos_printer`,
which gets real OS-level USB/Bluetooth/network socket access — something
Dart's mobile runtime provides natively. The web app has no printer feature
yet, and browsers fundamentally cannot do what the mobile runtime does:

- No raw TCP sockets from any browser → **network/Wi-Fi printers are
  unreachable directly**, on any OS or browser.
- WebUSB/Web Bluetooth/Web Serial are Chromium-only — **zero support in
  Safari**, and even on Chrome/Edge, WebUSB on Windows commonly can't claim
  a USB printer's interface because Windows' own driver already claims it
  first (confirmed against WebUSB's own driver-claiming rule, and Windows is
  the specific documented exception case).
- We evaluated "try WebUSB first, add a bridge only if needed" and rejected
  it: WebUSB only ever covers USB printers (never network, never Safari),
  and its reliability is per-printer-model and can silently regress after a
  Windows Update or printer firmware change — not something to gate the
  whole architecture on.
- We evaluated triggering the OS system print dialog instead: rejected as
  primary path because it removes headless one-tap printing (a dialog + a
  manual click on every single receipt), drops ESC/POS commands (auto-cut,
  cash drawer), and still requires every printer to already be registered
  as a proper Windows printer with a driver — no smaller a setup burden than
  installing a bridge, just a different one.

**Decision: use QZ Tray as a local bridge.** It's a small background app
installed once on the shop's Windows PC (customer base is Windows-focused).
It gets normal OS-level access to USB/Serial/network printers (standing in
for what `unified_esc_pos_printer` gives the mobile app natively) and
exposes a local WebSocket (`wss://localhost:8181`) that any browser —
including Safari — can call without any device-permission prompts or
driver-claiming conflicts. Confirmed current: QZ Tray 2.2.6 (April 2026),
actively maintained, bundles its own Java (no separate Java install needed).

**Explicitly rejected**: the `qz` package on pub.dev (3 likes, 50/160 pub
points, no verified publisher — too low quality to depend on). Instead,
build a small first-party `dart:js_interop` wrapper directly against QZ's
own official `qz-tray.js` client library (maintained by the `qzind/tray`
project itself, confirmed on npm as `qz-tray`) — full control, no
third-party Dart-wrapper risk.

**Signing certificate**: deferred per decision. Without it, the browser
shows a one-time "Allow this site to print?" prompt per QZ Tray session —
accepted for now; revisit if/when silent printing becomes worth the paid
certificate.

## Architecture (mirrors this repo's `lib/features/thermal_printer/`)

```
Presentation (Cubit + Pages)
      │ entities only, no JS/browser types
      ▼
Domain (entities, IPrinterRepository interface, usecases)
      │ implemented by
      ▼
Data (QzTrayDatasource — only place touching qz-tray.js, Models, RepositoryImpl)
      │ dart:js_interop, .toDart on JSPromise (confirmed current recommended
      │ pattern — see dart.dev/interop/js-interop/usage)
      ▼
qz-tray.js (self-hosted in web/, loaded via web/index.html)
      │ wss://localhost:8181
      ▼
QZ Tray (installed once on the shop's Windows PC)
      │ USB / Serial / raw TCP
      ▼
Thermal printer
```

Reference pattern in this repo (do not copy code — different platform — but
mirror the layering and naming conventions):

- `lib/features/thermal_printer/domain/entities/printer_device_entity/`
- `lib/features/thermal_printer/domain/repositories/i_thermal_printer_repository.dart`
- `lib/features/thermal_printer/data/repositories/thermal_printer_repository_impl.dart`
- `lib/features/thermal_printer/data/datasources/thermal_printer_datasource.dart`
- `lib/features/thermal_printer/presentation/print/bloc/thermal_printer_cubit/`

## Pre-flight checks (do these first, in the web project)

1. Confirm Flutter SDK ≥ 3.13 / Dart ≥ 3.3 (required for modern
   `dart:js_interop`, WASM-compatible — the interop code below assumes it).
2. Confirm `get_it`, `freezed`, `flutter_bloc` are already project
   dependencies, using the same DI/entity/cubit conventions as this app's
   `CLAUDE.md`. If this is a genuinely fresh feature area, add them
   following those conventions.

## Step 1 — `web/index.html` setup

Self-host `qz-tray.js` + its two dependencies (`rsvp.min.js`,
`sha-256.min.js`) under `web/qz/` — do not load from a third-party CDN
(printing shouldn't break because an external host is unreachable). Pin the
client version to match whatever QZ Tray desktop version (2.2.6+) shops are
told to install.

```html
<script src="qz/rsvp.min.js"></script>
<script src="qz/sha-256.min.js"></script>
<script src="qz/qz-tray.js"></script>
```

Loaded before Flutter's own bootstrap script.

## Step 2 — Data layer

### 2.1 `data/datasources/qz_tray_js_bindings.dart`

First-party `@JS()` external declarations, only the subset actually needed:
`qz.websocket.connect`, `qz.websocket.isActive`, `qz.websocket.disconnect`,
`qz.printers.find`, `qz.configs.create`, `qz.print`. Each Promise-returning
call wrapped with `.toDart` inside the datasource, per the confirmed current
`dart:js_interop` pattern.

**Verify before finalizing**: the exact JSON shape `qz.print()` expects for
raw ESC/POS data (historically `{type: 'raw', format: 'plain'|'hex', data:
...}`) — confirm against `qz.io/docs` rather than guessing.

### 2.2 `data/datasources/qz_tray_datasource.dart`

Thin wrapper (mirrors `ThermalPrinterDatasource` in this repo):
`isAvailable()`, `connect()`, `findPrinters()`,
`printRaw(printerName, Uint8List escPosBytes)`, `disconnect()`.

### 2.3 Models + repository impl

- `PrinterDeviceModel({required String name})` — QZ only returns printer
  *names*, no address/port/connection-type breakdown like the mobile app's
  scan gives.
- `QzPrinterRepositoryImpl implements IPrinterRepository` — calls the
  datasource, maps model→entity, wraps calls in this project's
  `safeApiCall`-equivalent (or local try/catch → typed exception).

## Step 3 — Domain layer

```dart
@freezed
abstract class PrinterDeviceEntity with _$PrinterDeviceEntity {
  const factory PrinterDeviceEntity({required String name}) = _PrinterDeviceEntity;
}

@freezed
abstract class PrintJobEntity with _$PrintJobEntity {
  const factory PrintJobEntity({required Uint8List escPosBytes}) = _PrintJobEntity;
}

abstract class IPrinterRepository {
  Future<bool> isBridgeAvailable();
  Future<void> connectToBridge();
  Future<List<PrinterDeviceEntity>> findPrinters();
  Future<void> print(String printerName, PrintJobEntity job);
}
```

Usecases (single public method, no state — same convention as mobile):
`CheckPrintBridgeAvailableUseCase`, `ConnectPrintBridgeUseCase`,
`FindPrintersUseCase`, `PrintReceiptUseCase(printerName, PrintJobEntity job)`.

## Step 4 — Building the receipt bytes (what presentation must provide)

Domain/data only need one thing from presentation: a fully-built
`PrintJobEntity` (raw ESC/POS bytes). Use **`esc_pos_utils_plus`** (pub.dev:
140/160 pub points, verified publisher, pure Dart, no native/platform
code — confirmed web-compatible) to build the `Ticket` the same way
`unified_esc_pos_printer`'s `Ticket` is used on mobile (`.text()`, `.row()`,
`.feed()`, `.cut()`, `.image()`).

**Decision, consistent with the mobile app**: mirror mobile's
image-raster approach (render receipt via Flutter widgets → monochrome
threshold → pass pixels to `esc_pos_utils_plus`'s image/raster command) —
not native ESC/POS text commands. This keeps identical visual output and
avoids reopening the multi-language (Malayalam/etc.) risk that mobile
already worked through and deliberately avoided for native text.

**Verify before finalizing**: `esc_pos_utils_plus`'s `.image()` method's
exact signature/behavior — confirmed the package exists and is
well-maintained, but its image API surface hasn't been hands-on tested
against this specific need.

## Step 5 — Presentation layer

- `QzPrinterCubit` — states: `bridgeUnavailable`, `disconnected`,
  `connecting`, `connected`, `printing`, `error`. Same shape as this repo's
  `ThermalPrinterState`, minus Bluetooth-permission fields (not applicable).
- Print screen: on entry, call `CheckPrintBridgeAvailableUseCase` — if
  false, show "QZ Tray isn't running — [Download QZ Tray] [Retry]" as a
  first-class expected state, not an edge case. If true, call
  `FindPrintersUseCase`, show a simple printer-name picker (no rich device
  cards — QZ doesn't expose connection-type/address like mobile's scan
  does), then a Print button calling `PrintReceiptUseCase`.
- No reconnect/lifecycle-observer complexity needed — unlike mobile's
  BLE/network connectors, there's no persistent per-device connection to
  maintain; each print is "connect to QZ Tray if needed → send bytes →
  done." Simpler state machine than the mobile cubit ended up needing.

## Open items to resolve during implementation, not before

1. ~~`qz.print()`'s exact raw-data payload shape~~ — **resolved**, see
   "Amendments made during implementation" #4.
2. ~~`esc_pos_utils_plus`'s `.image()` API~~ — **resolved**, see
   "Amendments made during implementation" #5.
3. **Still open**: document the QZ Tray desktop version ↔ `qz-tray.js`
   client version pairing somewhere so a QZ Tray upgrade doesn't silently
   break the web client. Currently only recorded inline as a code comment
   in `web/index.html` and this file (pinned to 2.2.6) — no dedicated
   compatibility doc yet.
4. **New — not yet built**: nothing in this repo currently calls
   `QzPrintScreen` from a real receipt flow (booking/sale detail, etc.).
   The feature (domain/data/presentation/DI) is fully wired and analyzer-
   clean, but building the actual `ReceiptCanvas`/`PrintTicketBuilder`
   call site for a specific receipt screen — mirroring mobile's
   `presentation/receipt_design/` — is follow-up work, not done here.

## Verification (in the web project)

1. Install QZ Tray 2.2.6 on a Windows test machine.
2. Run the web app pointed at that machine's browser; confirm
   `CheckPrintBridgeAvailableUseCase` correctly detects QZ Tray
   running/not-running (test both states — install/uninstall or
   start/stop QZ Tray).
3. Confirm `FindPrintersUseCase` lists a real connected printer (test at
   least one of each transport type in your fleet: USB, network, BLE via
   QZ Tray's serial/Bluetooth support if applicable).
4. Print a real receipt end-to-end; confirm layout matches the mobile
   app's visual output (since the design intentionally mirrors it) and
   that cut/feed commands work on actual hardware.
5. Test the one-time browser "Allow" prompt flow (unsigned mode, per the
   deferred-certificate decision) to confirm it's not blocking or
   confusing for a first-time user.
