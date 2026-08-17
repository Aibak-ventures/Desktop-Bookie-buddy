/// How a "Print" action should be fulfilled — thermal receipt via the
/// connected QZ Tray printer, a browser-rendered PDF invoice (system print
/// dialog), or asking the user each time.
///
/// NOTE: this is currently persisted locally only (`SharedPreferenceHelper`,
/// via `IPrinterRepository.get/savePrintOutputPreference`) — there is no
/// backend field or endpoint for it yet, so it's per-device, not synced
/// across devices on the same account. `fromJson`/`toJson`/[value] are
/// defined now so wiring this into `ShopSettingsModel` (once a backend
/// field exists) is a mapping change only, not a rewrite of call sites.
enum PrintOutputPreference {
  receipt('RECEIPT', 'Thermal receipt'),
  pdfInvoice('INVOICE_PDF', 'PDF invoice'),
  askEveryTime('ASK_EVERY_TIME', 'Ask every time');

  const PrintOutputPreference(this.value, this.label);

  final String value;
  final String label;

  static PrintOutputPreference fromJson(String? value) {
    if (value == null) return PrintOutputPreference.askEveryTime;
    return PrintOutputPreference.values.firstWhere(
      (e) => e.value == value,
      orElse: () => PrintOutputPreference.askEveryTime,
    );
  }

  static String toJson(PrintOutputPreference preference) => preference.value;
}
