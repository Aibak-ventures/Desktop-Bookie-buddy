# QZ Tray (`qz-tray.js`) reference

Source: `web/qz/qz-tray.js` (bundled, v2.2.6 — self-hosted, not pulled from a
CDN). This is QZ Tray's own JS client library for talking to the **QZ Tray
desktop app**, which runs on the user's machine and is the only thing with
actual OS-level access to printers/USB/serial devices. The browser (and this
Flutter web app) never talks to hardware directly — it always goes
`Flutter app → qz-tray.js → WebSocket → QZ Tray desktop app → OS/driver → printer`.

This doc exists so you don't have to re-read the 2974-line file to remember
what a call needs/returns. It's hand-written from reading the file directly
(its JSDoc comments + implementation), not from QZ's online docs, so it
reflects **this exact bundled version**, including one place where the
JSDoc is misleading (see `qz.printers.setPrinterCallbacks` under
[`qz.printers`](#qzprinters) below).

---

## How it loads and connects (this app specifically)

Load order matters, wired in `web/index.html`:

```text
qz/qz-tray.js            → defines the global `qz` object
qz/jsrsasign-all-min.js  → defines KEYUTIL/KJUR, used for signing
qz/qz-sign-message.js    → wires request signing using the two above
```

`qz-sign-message.js` (this app's own file, adapted from QZ's reference
implementation) calls `qz.security.setCertificatePromise(...)` and
`qz.security.setSignaturePromise(...)` once, at load time, using a
self-signed cert/private key checked into this repo
(`web/qz/digital-certificate.txt`). This is what stops QZ Tray from
showing an "Allow this site to print?" popup on every privileged call —
QZ Tray only prompts for **unsigned** connections. See that file's own doc
comment for the security tradeoff this implies (fine for a single shop's
own kiosk, not for a public multi-tenant deployment).

Every privileged call below (`connect`, `find`, `print`, `startListening`,
`getStatus`, ...) is signed transparently once this wiring is in place —
nothing in the Dart code has to think about signing.

---

## Namespaces at a glance

| Namespace | Used by this app? | What it's for |
| --- | --- | --- |
| `qz.websocket` | ✅ | Connect/disconnect to QZ Tray, connection status |
| `qz.printers` | ✅ | List printers, live status |
| `qz.configs` | ✅ | Build a `Config` object naming a target printer + print options |
| `qz.print` (top-level function) | ✅ | Actually send data to a printer |
| `qz.security` | ✅ (via `qz-sign-message.js` only) | Wire up request signing/certificate |
| `qz.api` | ✅ (partially — `getVersion`) | Debugging flags, version checks, misc |
| `qz.serial` | ❌ not used | Talk to serial-port devices (scales, scanners) |
| `qz.usb` | ❌ not used | Raw USB HID-adjacent device access |
| `qz.hid` | ❌ not used | USB Human Interface Devices (card readers, etc.) |
| `qz.file` | ❌ not used | Read/write files on the user's filesystem via QZ Tray |
| `qz.socket` | ❌ not used | Raw TCP socket access via QZ Tray |
| `qz.networking` | ❌ not used | Query the local machine's network interfaces |

Only the first six are documented in detail below. If a future feature needs
one of the "not used" namespaces, the pattern in
["Adding a new binding"](#adding-a-new-binding-in-dart) applies the same way —
open `qz-tray.js`, search for `@namespace qz.<name>`, and read its JSDoc block.

---

## `qz.websocket`

The connection to the QZ Tray desktop app itself. Nothing else works until
this is connected.

### `qz.websocket.isActive()`

- **Takes:** nothing
- **Returns:** `boolean` — synchronous, not a promise
- Used by this app (`QzTrayDatasource.connect()`/`isAvailable()`) to skip
  reconnecting if already connected.

### `qz.websocket.connect([options])`

- **Takes:** optional `options` object — `host`, `port.secure`/`port.insecure`
  (defaults try `localhost`/`localhost.qz.io` on ports 8181/8282/8383/8484
  secure, 8182/8283/8384/8485 insecure), `usingSecure`, `keepAlive` (seconds,
  default 60), `retries`, `delay`. This app calls it with no options — QZ
  Tray's defaults are used.
- **Returns:** `Promise<null | Error>` — rejects if QZ Tray isn't running
  (nothing listening on those ports) or the handshake fails.
- This is the call that triggers the "Allow this site to print?" popup if
  the request isn't signed (see [connect/wiring](#how-it-loads-and-connects-this-app-specifically)).

### `qz.websocket.disconnect()`

- **Takes:** nothing · **Returns:** `Promise<null | Error>` — rejects if
  there's no open connection.

### `qz.websocket.setErrorCallbacks(calls)` / `setClosedCallbacks(calls)`

- **Takes:** a function or array of functions, each `Function(event)`,
  fired for connection errors/close events that happen **outside** a
  specific API call (e.g. QZ Tray crashes mid-session). Not currently
  wired up by this app — errors are instead caught per-call.

### `qz.websocket.getConnectionInfo()`

- **Takes:** nothing · **Returns:** `{socket, host, port}` object,
  synchronous. Not currently used by this app.

---

## `qz.printers`

### `qz.printers.find([query])`

- **Takes:** optional `query` string to filter to one printer name.
- **Returns:** `Promise<Array<string> | string | Error>` — the OS/driver's
  installed printer list (or the one matching `query`). This is a **static
  snapshot of paired/installed printers** — it says nothing about whether a
  printer is currently powered on or reachable. See `getStatus` below for
  that.
- Wrapped by this app in `QzTrayDatasource.findPrinters()`.

### `qz.printers.details()`

- **Takes:** nothing · **Returns:** `Promise<Array<Object> | Object | Error>`
  — same idea as `find()` but with extra per-printer metadata (driver info).
  Not used by this app; `find()` is enough for a name-only picker.

### `qz.printers.startListening(printers[, options])`

- **Takes:** `printers` — `null` (all), a single printer name string, or an
  array of names. `options` (Windows-only, unused here): `jobData`,
  `maxJobData`, `flavor`.
- **Returns:** `Promise<null | Error>` — resolves once QZ Tray has
  registered the listener; doesn't itself deliver any status.
- Required before `getStatus()` will report anything for those printers.

### `qz.printers.getStatus()`

- **Takes:** nothing · **Returns:** `Promise<null | Error>` — resolving this
  promise only means *the request was sent*. The actual status data is
  delivered **asynchronously**, one event at a time, to whatever callback
  was registered via `setPrinterCallbacks` (below) — not via this promise's
  resolved value.

### `qz.printers.setPrinterCallbacks(calls)` {#qzprintenanterssetprintercallbacks}

- **Takes:** a function or array of functions.
- **⚠️ The JSDoc here is easy to misread.** It's documented as
  `Function({Object} eventData)` — singular — and that's exactly right, but
  it's worth spelling out because it's a common trap: **QZ calls this once
  per event**, each call passing **one plain object**, never a batched
  array. Confirmed from `qz-tray.js`'s own implementation, not just its
  doc comment:

  ```js
  callPrinter: function(streamEvent) {
      if (Array.isArray(_qz.printers.printerCallbacks)) {
          for (var i = 0; i < _qz.printers.printerCallbacks.length; i++) {
              _qz.printers.printerCallbacks[i](streamEvent);   // one event
          }
      } else {
          _qz.printers.printerCallbacks(streamEvent);          // one event
      }
  }
  ```

- **⚠️ Second JSDoc mismatch, also confirmed wrong against a real device:**
  the doc claims the event carries `printerName`/`status`. The actual
  runtime payload (logged from a real QZ Tray instance/printer) is:

  ```text
  {printerName, eventType, statusText, severity, statusCode, message, type}
  ```

  — the human-readable status field is **`statusText`**, not `status`
  (`status` doesn't exist on the real object at all). Example events seen
  from a real 2-printer setup:

  ```text
  {printerName: "Printer POS-80", eventType: PRINTER, statusText: OK, severity: INFO, statusCode: idle, ...}
  {printerName: "4BARCODE 4B-2054TF", eventType: PRINTER, statusText: OFFLINE, severity: FATAL, statusCode: offline-report, ...}
  {printerName: "4BARCODE 4B-2054TF", eventType: PRINTER, statusText: PAUSED, severity: WARN, statusCode: paused, ...}
  ```

  `severity` (`INFO`/`WARN`/`ERROR`/`FATAL`) turned out to be the more
  reliable field to key off of — it's a small, QZ-assigned set, unlike
  `statusText`, which is driver-specific free text with no fixed enum
  (`"OK"`, `"OFFLINE"`, `"PAUSED"`, ...). This app's `_parseStatus` uses
  `severity` first, falling back to `statusText` substring-matching only
  if severity is missing/unrecognized. Trust what you log from a real
  device over this JSDoc for anything printer-status related — it's wrong
  twice over in this one call alone.

### `qz.printers.stopListening()`

- **Takes:** nothing · **Returns:** `Promise<null | Error>` — stops all
  status listening (not per-printer).

### `qz.printers.clearQueue([options])`

- **Takes:** a printer name string, or `{printerName, jobId}` to cancel one
  specific job. **Returns:** `Promise<null | Error>`. Not used by this app.

---

## `qz.configs`

### `qz.configs.create(printer[, options])`

- **Takes:** `printer` — a printer name string, or an object
  (`{name}`/`{file}`/`{host, port}`) to target a file or network host
  instead of a named printer. `options` overrides any of `setDefaults`'
  fields for this config only (paper size, margins, copies, density,
  duplex, ...) — this app doesn't pass any, since raw ESC/POS bytes don't
  need paper-size/margin config the way a PDF/HTML print would.
- **Returns:** a `Config` object (opaque — hand it straight to `qz.print()`).
- This app's `QzTrayDatasource.printRaw()` calls this per print with just a
  printer name.

### `qz.configs.setDefaults(options)`

- **Takes:** the same `options` shape as `create()`'s second argument, but
  applied globally to all future configs that don't override it. Not used
  by this app — every config is per-print with app-level defaults baked
  into the ESC/POS bytes themselves (via `esc_pos_utils_plus`), not QZ's
  config layer.

---

## `qz.print(configs, data[, resumeOnError, signature, signingTimestamp])`

- **Takes:**
  - `configs` — one `Config` (from `qz.configs.create`) or an array of them.
  - `data` — an array of data entries. Each entry is either a plain string
    (interpreted as `{type: 'raw', format: 'command', flavor: 'plain'}`) or
    an object:
    - `type`: `'pixel'` or `'raw'` (default `'raw'`)
    - `format`: for `raw` — `'command'` (default), `'html'`, `'image'`,
      `'pdf'`
    - `flavor`: for `command` format — `'base64' | 'file' | 'hex' | 'plain' (default) | 'xml'`
    - `data`: the actual payload (string)
    - `options`: format-specific extras (language, quantization threshold,
      x/y position, dot density, image encoding, etc.) — not used by this
      app, which sends pre-built ESC/POS bytes and needs none of them.
  - This app (`QzTrayDatasource.printRaw`) always sends exactly one entry:
    `{type: 'raw', format: 'command', flavor: 'base64', data: <base64 ESC/POS bytes>}`.
- **Returns:** `Promise<null | Error>` — resolves once QZ Tray has accepted
  and *sent* the job to the OS/printer. This does **not** mean the physical
  printer has finished (or even started) printing — QZ Tray doesn't track
  that.

---

## `qz.security`

Only ever called once, at app startup, by `web/qz/qz-sign-message.js` — not
from Dart at all.

- **`setCertificatePromise(promiseHandler[, options])`** — registers how QZ
  Tray fetches this app's public certificate. This app resolves it via
  `fetch('qz/digital-certificate.txt')`.
- **`setSignaturePromise(promiseFactory)`** — registers how each outgoing
  call's payload gets signed. This app signs with `jsrsasign`'s
  `KJUR.crypto.Signature` using the private key embedded in
  `qz-sign-message.js`.
- **`setSignatureAlgorithm(algorithm)`** — this app uses `'SHA512'`.
- **`getSignatureAlgorithm()`** — returns whatever was set. Not used.

---

## `qz.api`

Small grab-bag of debugging/version helpers.

- **`getVersion()`** → `Promise<string | Error>` — connected QZ Tray's
  version. Not currently called by this app but useful for diagnostics.
- **`showDebug(show)`** → toggles QZ's own console logging. Synchronous.
- **`isVersion`/`isVersionGreater`/`isVersionLess`(major, minor, patch[, build])**
  → version comparisons against the connected QZ Tray.
- **`setPromiseType`/`setSha256Type`** → swap QZ's internal Promise/hash
  implementations. Never needed in a modern browser — QZ's own defaults
  are fine.

---

## How this maps into Dart

This app never calls `qz.*` directly from Dart — everything goes through
one file, **`lib/features/printer/data/datasources/qz_tray_js_bindings.dart`**,
which declares `dart:js_interop` `external` bindings for the subset of the
`qz` object actually used, and **`qz_tray_datasource.dart`**, which is the
only place that calls those bindings.

### The pattern for a JS *object with methods you call* (Dart → JS)

```dart
@JS('qz')
external QzTrayJs get qzTray;

@JS()
@staticInterop
class QzTrayJs {}

extension QzTrayJsExtension on QzTrayJs {
  external QzWebsocketJs get websocket;
  external QzPrintersJs get printers;
}

@JS()
@staticInterop
class QzPrintersJs {}

extension QzPrintersJsExtension on QzPrintersJs {
  external JSPromise find();
}
```

Then on the Dart side, `await qzTray.printers.find().toDart` — every JS call
returns a `JSPromise`, converted with `.toDart` only at the call site (never
inside the bindings file itself, per that file's own doc comment).

### The pattern for a *callback JS calls into you* (JS → Dart) — the trap to avoid

This is the one that actually broke (twice) building the printer-status
feature — worth internalizing.

**Don't** declare the callback parameter with a specific generic JS type,
even though it looks like the "more correct" typed option:

```dart
// Looks reasonable, throws at runtime:
external void setPrinterCallbacks(JSFunction callback);
void onStatus(JSArray<JSObject> events) { ... }   // ❌
qzTray.printers.setPrinterCallbacks(onStatus.toJS);
```

Dart's web runtime validates the actual JS value QZ passes in against that
declared generic type *before* your code runs. QZ builds its event objects
as plain native JS objects (via `JSON.parse`), which don't satisfy that
check — the call throws (`LegacyJavaScriptObject is not a subtype of
JSArray<...>`) and your callback body never executes. Symptom: no crash
visible anywhere near your own code, just silent failure — every request
this callback was supposed to answer just times out.

**Do** accept the loosest possible type and unpack manually:

```dart
void onStatus(JSAny? eventAny) {
  final event = eventAny?.dartify();   // walks JS → plain Dart Map/List, no type-brand check
  if (event is! Map) return;
  final printerName = event['printerName'] as String?;
  final statusText = event['statusText'] as String?;   // not `status` — see qz.printers above
  // ...
}
qzTray.printers.setPrinterCallbacks(onStatus.toJS);
```

`.dartify()` is the safe general-purpose escape hatch any time JS calls
*into* Dart with a shape you don't fully control — it can't fail the way a
generically-typed `external` callback parameter can.

### Adding a new binding in Dart

1. Open `web/qz/qz-tray.js`, search for `@namespace qz.<name>` to find the
   section, and this doc's matching heading above for a plain-English
   summary — or add a new section here first if it's a namespace not yet
   covered.
2. Add an `external` declaration to `qz_tray_js_bindings.dart` under the
   matching `QzXxxJs` extension (create one if the namespace isn't bound
   yet, following `QzPrintersJs`'s shape).
3. Add the actual calling code to `qz_tray_datasource.dart` — this is the
   **only** file allowed to touch the bindings directly; everything else in
   the printer feature works with plain Dart entities/futures.
4. If the call is a *callback QZ invokes* (not a promise you `await`), use
   the `JSAny?` + `.dartify()` pattern above, not a typed `JSArray<...>`/
   extension-type parameter.
