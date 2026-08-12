// ignore_for_file: non_constant_identifier_names
//
// First-party `dart:js_interop` bindings for QZ Tray's official
// `qz-tray.js` client (self-hosted at web/qz/qz-tray.js — see
// thermal-printer-implementation-plan.md for why the `qz` pub.dev package
// was rejected in favor of binding directly against QZ's own JS library).
//
// Only the subset actually needed is declared here. Every JS call in this
// file returns a `JSPromise` — callers convert with `.toDart` (the
// confirmed-current `dart:js_interop` pattern, see
// dart.dev/interop/js-interop/usage) inside `QzTrayDatasource`, never here.
import 'dart:js_interop';

/// The global `qz` object injected by `web/qz/qz-tray.js`, loaded in
/// `web/index.html` before Flutter's own bootstrap script.
@JS('qz')
external QzTrayJs get qzTray;

@JS()
@staticInterop
class QzTrayJs {}

extension QzTrayJsExtension on QzTrayJs {
  external QzWebsocketJs get websocket;
  external QzPrintersJs get printers;
  external QzConfigsJs get configs;

  /// `qz.print(config, data)` — see [QzConfigsJs.create] for building
  /// `config` and [QzPrintDataJson] for `data`'s shape.
  external JSPromise print(JSObject config, JSArray<JSObject> data);
}

@JS()
@staticInterop
class QzWebsocketJs {}

extension QzWebsocketJsExtension on QzWebsocketJs {
  external JSPromise connect([JSObject? options]);
  external JSBoolean isActive();
  external JSPromise disconnect();
}

@JS()
@staticInterop
class QzPrintersJs {}

extension QzPrintersJsExtension on QzPrintersJs {
  /// Resolves to a `JSArray<JSString>` of installed printer names.
  external JSPromise find();

  /// Registers the callback QZ Tray pushes printer status events to
  /// (fired for any printer passed to [startListening], any time its
  /// status changes, and once per printer after [getStatus]). Confirmed
  /// against the bundled `web/qz/qz-tray.js`'s own JSDoc/implementation
  /// (`printers.setPrinterCallbacks`/`printers.callPrinter`): the callback
  /// fires **once per event** — never a batched array — with a single
  /// plain JS object carrying `{string} printerName` and `{string}
  /// status` (plus `output`/`exception`/`actionType` depending on event
  /// type, unused here). Registered with an untyped `JSAny?` parameter and
  /// unpacked via `dartify()` on the Dart side (see
  /// `QzTrayDatasource.getPrinterStatuses`) rather than a statically-typed
  /// extension-type parameter, since DDC's strict runtime argument check
  /// on a generically-typed callback parameter rejects the native object
  /// QZ actually calls back with.
  external void setPrinterCallbacks(JSFunction callback);

  /// Starts listening for status events on [printerNames] — required
  /// before [getStatus] will report anything for them.
  external JSPromise startListening(JSArray<JSString> printerNames);

  /// Stops listening for status events on all printers.
  external JSPromise stopListening();

  /// Asks QZ Tray to push the current status of every actively-listened
  /// printer (see [startListening]) to the callback registered via
  /// [setPrinterCallbacks]. Resolves once the request is sent — the actual
  /// status arrives asynchronously via the callback, not this promise.
  external JSPromise getStatus();
}

@JS()
@staticInterop
class QzConfigsJs {}

extension QzConfigsJsExtension on QzConfigsJs {
  /// `qz.configs.create(printerName)` — returns an opaque `Config` object,
  /// passed straight back into `qz.print()`.
  external JSObject create(JSString printerName);
}

/// Literal object shape `qz.print()` expects per raw data entry — confirmed
/// against the bundled `qz-tray.js` v2.2.6 JSDoc (`data.type`/`data.format`/
/// `data.flavor`/`data.data`):
/// `{type: 'raw', format: 'command', flavor: 'base64', data: <string>}`.
/// `base64` is used (not `plain`/`hex`) since ESC/POS payloads here include
/// raw raster image bytes, not printable/hex-safe text.
extension type QzPrintDataJson._(JSObject _) implements JSObject {
  external factory QzPrintDataJson({
    String type,
    String format,
    String flavor,
    String data,
  });
}
